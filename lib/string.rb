class String
  # Returns index for first occurrence of delimiter or nil if it doesn't exist
  #
  # Examples:
  #   "Nick: Line".delimiter      # => 4
  #   "* Nick performs an action" # => 0
  def delimiter
    self.index('*') || self.index(':')
  end
  
  # Returns an array of lines using the new line carriage as the delimiter
  #
  # Examples:
  #   "Line 1\nLine 2\".lines # => ["Line 1", "Line 2"]
  def lines
    self.split("\n")
  end
end
