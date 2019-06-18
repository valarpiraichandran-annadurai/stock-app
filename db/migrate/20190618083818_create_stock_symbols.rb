class CreateStockSymbols < ActiveRecord::Migration
  def change
    create_table :stock_symbols do |t|
      t.string :symbol

      t.timestamps null: false
    end

    add_index :stock_symbols, :symbol, unique: true
  end
end
