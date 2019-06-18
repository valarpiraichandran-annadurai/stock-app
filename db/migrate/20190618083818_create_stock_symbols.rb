class CreateStockSymbols < ActiveRecord::Migration
  def change
    create_table :stock_symbols do |t|
      t.string :symbol

      t.timestamps null: false
    end
  end
end
