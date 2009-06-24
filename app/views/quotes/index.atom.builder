atom_feed do |feed|
  feed.title 'Quotes'
  feed.updated Time.now
  
  @quotes.each do |quote|
    feed.entry(quote) do |entry|
      entry.title quote.number
      entry.content quote.lines
    end
  end
end
