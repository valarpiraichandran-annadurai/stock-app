class AddPriceLastupdatedToStockSymbol < ActiveRecord::Migration
  def change
    add_column :stock_symbols, :price, :decimal
  end
end
