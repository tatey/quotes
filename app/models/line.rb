class Line
  attr_reader :nick, :colour, :text
  
  def initialize(nick, colour, text)
    @nick   = nick
    @colour = colour
    @text   = text
  end
end
