# Load sample stub data

namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_users
    make_stock_symbols
  end
end

def make_users
  puts "Creating users..."
  User.create!(name: "Example User",
                 email: "example@mailinator.org",
                 password: "test123",
                 password_confirmation: "test123",
                 admin: true)
end

def make_stock_symbols
  puts "Creating stock symbols"
  # StockSymbol.create!(symbol: "SPY",
  #               name: "SPDR S&P 500")

  [
        {
            :symbol => "SPY",
            :name => "SPDR S&P 500"
        },
        {
            :symbol => "CMCSA",
            :name => "Comcast Corporation Class A Common Stock"
        },
        {
            :symbol => "KMI",
            :name => "Kinder Morgan Inc."
        }].each do |item|
          StockSymbol.create(item)
        end
end
