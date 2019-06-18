class StockSymbol < ActiveRecord::Base
  has_many :stockhistory, dependent: :destroy

  before_save { self.symbol = symbol.upcase }


  validates :symbol, presence:true, uniqueness: { case_sensitive: false }, length: { maximum: 10}
  validates :name, presence:true
end
