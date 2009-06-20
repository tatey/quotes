class Quote < ActiveRecord::Base
  has_many :votes, :dependent => :destroy
  
  validates_presence_of :text
          
  def lines
    text.split("\n")
  end
  
  def score
    score = 0
    score += votes.up.count
    score -= votes.down.count
  end
end
