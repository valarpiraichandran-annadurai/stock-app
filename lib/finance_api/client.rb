require 'faraday'
require 'json'

require_relative './errors'

module FinanceAPI

  class Client
    def hostname
      'https://financialmodelingprep.com/api/v3/'
    end

    def get_auth_token
      # No Auth required for this API
    end

    def initialize
      @client = Faraday.new(:url => self.hostname)
    end

    def get(url_or_path, params = nil)
      response = @client.get url_or_path do |req|
        req.url(url_or_path)
        req.options.params_encoder = Faraday::NestedParamsEncoder
        req.headers['Content-Type'] = 'application/json'
        req.params = params if params
      end
      handle_response(response)
    end

    def post(url_or_path, body)
      response = @client.get url_or_path do |req|
        req.url(url_or_path)
        req.body = body.to_json
        req.headers['Content-Type'] = 'application/json'
      end
      handle_response(response)
    end

    def get_realtime_price(symbol: nil)
      # GET
      # https://financialmodelingprep.com/api/v3/stock/real-time-price/AAPL
      get("stock/real-time-price/#{symbol}", nil)
    end

    def get_realtime_price_list
      # GET
      # https://financialmodelingprep.com/api/v3/stock/real-time-price
      get("stock/real-time-price", nil)
    end

    def get_symbol_list
      # GET
      # https://financialmodelingprep.com/api/v3/company/stock/list
      get("company/stock/list", nil)
    end

    def get_price_history(symbol: nil)
      # GET
      # https://financialmodelingprep.com/api/v3/historical-price-full/AAPL?serietype=line
      get("historical-price-full/#{symbol}?serietype=line", nil)
    end

    protected

        def handle_response(response)
          # return response
          if (200...300).cover?(response.status) && (response.body.nil? || response.body.empty?)
            return
          end

          raise InternalServerError, "Server error got #{response.status}" if (500...600).cover?(response.status)

          begin
            json_data = JSON.parse(response.body)
            return { body: json_data, status: response.status }
          resque
            raise UnexpectedResponse, response.body
          end

          unless response.body.kind_of?(Hash)
            raise UnexpectedResponse, response.body
          end

          raise UnexpectedResponse, response.body['error'] if response.body['error']

          raise UnexpectedResponse, handle_errors(response) if response.body['errors']

          raise UnexpectedResponse, "Temporary Connection error: #{response.body}" if response.body['statusCode'] == 'ERROR'

          return { body: response.body, status: response.status }
        end

        def handle_errors(response)
          # Example error format
          # {
          #   "errors" : [ {
          #     "id" : "ce8c391e-f858-411b-a14b-5aa26e0915f2",
          #     "status" : "400",
          #     "code" : "PARAMETER_ERROR.INVALID",
          #     "title" : "A parameter has an invalid value",
          #     "detail" : "'uploadedDate3' is not a valid field name",
          #     "source" : {
          #       "parameter" : "sort"
          #     }
          #   } ]
          # }

          return response.body['errors'].map do |error|
            "#{error['title']} - #{error['detail']}"
          end.join(" ")
        end
  end
end
