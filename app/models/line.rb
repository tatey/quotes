class Line
  attr_reader :identifier, :style, :text
  
  def initialize(identifier, style, text)
    @identifier = identifier
    @style      = style
    @text       = text
  end
end
