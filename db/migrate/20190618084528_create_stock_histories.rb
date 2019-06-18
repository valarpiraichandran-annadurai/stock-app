class CreateStockHistories < ActiveRecord::Migration
  def change
    create_table :stock_histories do |t|
      t.integer :symbol_id
      t.decimal :price
      t.date :date

      t.timestamps null: false
    end
  end
end
