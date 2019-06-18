module FinanceAPI
  class Base

    def self.client
      if @client.nil?
        @client = Client.new
      end
      @client
    end

  end
end
