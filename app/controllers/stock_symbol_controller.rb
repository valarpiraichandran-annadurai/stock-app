require 'finance_api/base'

class StockSymbolController < ApplicationController
  def index
    @stock_symbols = StockSymbol.paginate(page: params[:page])
  end

  def show
    @stock_symbol = StockSymbol.find(params[:id])
    client = FinanceAPI::Base.client
    resp = client.get_realtime_price(symbol: @stock_symbol.symbol)
    puts resp
  end
end
