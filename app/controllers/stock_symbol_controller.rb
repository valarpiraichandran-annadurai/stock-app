require 'finance_api/base'

class StockSymbolController < ApplicationController
  def index
    @stock_symbol = StockSymbol.where(:deleted => false).paginate(page: params[:page], per_page: 50)
  end

  def show
    begin
      @stock_symbol = StockSymbol.find(params[:id])
    rescue
      puts "Stock symbol not found"
      render 'shared/not_found'
      return
    end

    if @stock_symbol.deleted
      render 'shared/not_found'
    end

    @stock_history = @stock_symbol.stock_history.paginate(page: params[:page], per_page: 50)

    if !@stock_symbol.stock_history.any?
      StockPriceHistoryJob.perform_later(@stock_symbol)
    end
  end

  def destroy
    StockSymbol.find(params[:id]).update(:deleted => true)
    flash[:success] = "Company deleted."
    redirect_to root_url
  end
end
