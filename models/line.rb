require 'digest/md5'

class Line
  attr_reader :identifier, :text, :style
  
  def initialize(line)
    @identifier = line.slice!(/^(\s*\*|[^:]+:)/)
    @text = line.strip
    @style = '#' + Digest::MD5.hexdigest(@identifier).slice(0, 6)
  end
end
