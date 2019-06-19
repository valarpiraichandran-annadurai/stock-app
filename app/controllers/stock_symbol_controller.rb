require 'finance_api/base'

class StockSymbolController < ApplicationController
  def index
    @stock_symbols = StockSymbol.paginate(page: params[:page])
  end

  def show
    @stock_symbol = StockSymbol.find(params[:id])

    two_minutes = 2 * 60

    if @stock_symbol.updated_at.nil? or (Time.now.getutc.to_i - @stock_symbol.updated_at.to_i) > two_minutes 
      client = FinanceAPI::Base.client
      @resp = client.get_realtime_price(symbol: @stock_symbol.symbol)[:body]

      @stock_symbol.update(:price => @resp['price'])
    end
  end
end
