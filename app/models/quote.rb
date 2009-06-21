class Quote < ActiveRecord::Base
  has_many :votes, :dependent => :destroy
  
  validates_presence_of :text
  
  named_scope :approved,   :conditions => { :approved => true }
  named_scope :unapproved, :conditions => { :approved => false }
          
  def lines
    text.split("\n")
  end
  
  def score
    score = 0
    score += votes.up.count
    score -= votes.down.count
  end
  
  def approve
    approved? || update_attribute(:approved, true)
  end
  
  def number
    '#%04d' % id
  end
end
