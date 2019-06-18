class StockSymbol < ActiveRecord::Base
  has_many :stockhistory, dependant: :destroy

  validates :symbol, presence:true, length: { maximum: 10}
end
