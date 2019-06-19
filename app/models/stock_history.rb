class StockHistory < ActiveRecord::Base
  belongs_to :stocksymbol, class_name: :StockSymbol, foreign_key: :symbol_id

  default_scope -> { order('date DESC') }

  validates :price, presence:true, :numericality => { :greater_than_or_equal_to => 1 }
  validates :date, presence:true
end
