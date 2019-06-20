class RealtimePriceFetchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Fetch realtime stock price every 3 minutes
    puts "Updating Realtime stock price...."
    client = FinanceAPI::Base.client

    @resp = client.get_realtime_price_list()[:body]

    if !@resp.key?("stockList")
      puts "Error while fetching realtime stock price.."
      return
    elsif @resp["stockList"].length < 1
      puts "Realtime stock price not available.."
      return
    end

    symbol_hash = {}

    puts "Found #{@resp["stockList"].length} symbols..."
    @resp["stockList"].each { |symbol| symbol_hash[symbol["symbol"]] = symbol["price"] }

    @stock_symbols = StockSymbol.where(:deleted => false)

    @stock_symbols.each do |symbol|      
      if symbol_hash.key?(symbol.symbol)
        # puts "Updating price for #{symbol.symbol}, #{symbol_hash[symbol.symbol]}"
        symbol.update(:price => symbol_hash[symbol.symbol])
      end
    end

    puts "Realtime stock price updated successfully..."
  end
end


job = Sidekiq::Cron::Job.new(name: 'Realtime Stock price - every 3min',
      cron: '*/5 * * * *', class: 'RealtimePriceFetchJob')

unless job.save
  puts job.errors # will return array of errors
end
