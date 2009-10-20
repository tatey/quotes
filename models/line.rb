require 'digest/md5'

class Line
  attr_reader :identifier, :identifier_type, :text, :hex_colour
    
  def initialize(line)
    @identifier = line.slice!(/^(\s*\*|[^:]+:)/)
    if @identifier.match(/^\s*\*/)
      @identifier_type = 'action'
    else
      @identifier_type = 'nick'
    end
    @text = line.strip
    if identifier_type != 'action'
      @hex_colour = '#' + Digest::MD5.hexdigest(identifier).slice(0, 6)
    end
  end  
end
