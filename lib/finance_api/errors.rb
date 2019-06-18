module FinanceAPI
class UnexpectedResponse < StandardError
    attr_reader :error_info

    def initialize(error_info = nil)
      super(error_info)
      @error_info = error_info
    end

    def preferred_error_info
      return nil unless @error_info.kind_of?(Hash) && @error_info['resultString']

      [
        "API provided the following error info:",
        @error_info['resultString'],
        @error_info['userString']
      ].compact.uniq # sometimes 'resultString' and 'userString' are the same value
    end
  end
end