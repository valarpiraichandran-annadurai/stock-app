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

    @stock_history = @stock_symbol.stock_history.paginate(page: params[:page], per_page: 50)
  end

  def destroy
    StockSymbol.find(params[:id]).update(:deleted => true)
    flash[:success] = "Company deleted."
    redirect_to root_url
  end
end
