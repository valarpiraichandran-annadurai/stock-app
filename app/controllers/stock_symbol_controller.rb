require 'finance_api/base'

class StockSymbolController < ApplicationController
  def index
    @stock_symbol = StockSymbol.where(:deleted => false).paginate(page: params[:page], per_page: 50)
  end

  def show
    @stock_symbol = StockSymbol.find(params[:id])

    if @stock_symbol.deleted
      redirect_to root_url
    end

    two_minutes = 2 * 60

    if @stock_symbol.updated_at.nil? or (Time.now.getutc.to_i - @stock_symbol.updated_at.to_i) > two_minutes 
      client = FinanceAPI::Base.client
      begin
        @resp = client.get_realtime_price(symbol: @stock_symbol.symbol)[:body]

        @stock_symbol.update(:price => @resp['price'])
      rescue
        puts "Error while fetching realtime price"
      end
    end
  end

  def destroy
    StockSymbol.find(params[:id]).update(:deleted => true)
    flash[:success] = "Company deleted."
    redirect_to root_url
  end
end
