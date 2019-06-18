class StockHistory < ActiveRecord::Base
  belongs_to :stocksymbol

  validates :price, presence:true, :numericality => { :greater_than_or_equal_to => 1 }
  validates :date, presence:true
end
