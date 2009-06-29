namespace :data do
  desc 'Import sample quotes'
  task :import => :environment do
    path = File.join(File.dirname(__FILE__), 'data.txt')
    file = File.open(path, 'r')
    text = ''
    file.each_line do |line|
      if line.match(/\A---/)
        Quote.create(:text => text, :approved => true)
        text = ''
      else
        text << line
      end
    end
    file.close
    
    Quote.all.each do |quote|
      attrs = {}
      lines = quote.text.split("\n")
      if lines.first.match(/\A~meta:date=/)
        attrs[:created_at] = lines.first.match(/(Mon|Tue|Wed|Thu|Fri|Sat|Sun).{22}/).to_s
        lines.delete_at(0)
        attrs[:text] = lines.join("\n")
      else
        attrs[:created_at] = 'Sun, 17 May 2009 21:11:13'
      end
      quote.update_attributes(attrs)
    end
  end
  
  desc 'Destroy all quotes and their votes'
  task :destroy_all => :environment do
    Quote.destroy_all
  end
end
