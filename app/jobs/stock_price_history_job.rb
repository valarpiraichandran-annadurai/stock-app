class StockPriceHistoryJob < ActiveJob::Base
  queue_as :default

  def perform(stock_symbol)
    puts "Updating Realtime stock price...."
    client = FinanceAPI::Base.client

    symbol_hash = {}

    if stock_symbol.nil?
      @stock_symbols = StockSymbol.where(:deleted => false).limit(10)
    else
      @stock_symbols = [stock_symbol]
    end

    @stock_symbols.each do |stock_symbol|
        @resp = client.get_price_history(symbol: stock_symbol.symbol)[:body]

        if !@resp.key?("historical")
          puts "Error while fetching stock price history for #{stock_symbol.symbol}.."
          next
        elsif @resp["historical"].length < 1
          puts "Realtime stock history not available for #{stock_symbol.symbol}..."
          next
        end

        @resp["historical"].each do |history| 
          # puts "Updating price for #{symbol.symbol}, #{symbol_hash[symbol.symbol]}"

          stock_symbol.stock_history.create!(:date => history['date'],
            :price => history['close'])
        end
      end

    puts "Stock price history updated successfully..."
  end
end
