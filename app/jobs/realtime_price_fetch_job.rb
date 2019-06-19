class RealtimePriceFetchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Fetch realtime stock price every 3 minutes
    puts "Updating Realtime stock price...."
    @stock_symbols = StockSymbol.all

    client = FinanceAPI::Base.client

    @stock_symbols.each do |symbol|
      puts "Updating for #{symbol.symbol}"
      @resp = client.get_realtime_price(symbol: symbol.symbol)[:body]

      symbol.update(:price => @resp['price'])
    end
  end
end


job = Sidekiq::Cron::Job.new(name: 'Realtime Stock price - every 3min',
      cron: '*/3 * * * *', class: 'RealtimePriceFetchJob')

unless job.save
  puts job.errors # will return array of errors
end