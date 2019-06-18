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
end

def make_stock_symbols
  puts "Creating stock symbols"
end