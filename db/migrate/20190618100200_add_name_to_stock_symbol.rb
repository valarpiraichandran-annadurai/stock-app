class AddNameToStockSymbol < ActiveRecord::Migration
  def change
    add_column :stock_symbols, :name, :string
  end
end
