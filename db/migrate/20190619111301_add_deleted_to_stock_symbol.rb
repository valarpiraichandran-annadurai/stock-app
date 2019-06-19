class AddDeletedToStockSymbol < ActiveRecord::Migration
  def change
    add_column :stock_symbols, :deleted, :boolean, :default => false
  end
end
