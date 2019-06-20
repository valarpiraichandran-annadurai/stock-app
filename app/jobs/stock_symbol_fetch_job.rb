class StockSymbolFetchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    puts "Updating Symbol list...."
    client = FinanceAPI::Base.client

    # TODO - Handle API error
    @resp = client.get_symbol_list()[:body]

    if !@resp.key?("symbolsList")
      puts "Error while fetching Symbol list.."
      return
    elsif @resp["symbolsList"].length < 1
      puts "Symbol list not available.."
      return
    end

    puts "Found #{@resp["symbolsList"].length} symbols..."

    # StockSymbol.destroy_all

    @resp["symbolsList"].each do |symbol|
      @symbol = StockSymbol.find_by(:name => symbol["name"])
      if @symbol.nil?
        StockSymbol.create!({
              :symbol => symbol["symbol"],
              :name => symbol["name"],
              :price => symbol["price"]
          })
      end
    end
    puts "Symbols list updated successfully..."
  end
end

# Manually run one time
# Fetch all stock symbols at startup
# StockSymbolFetchJob.perform_now
# StockSymbolFetchJob.perform_later
