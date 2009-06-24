class Quote < ActiveRecord::Base
  has_many :votes, 
           :dependent    => :destroy, 
           :after_add    => :calculate_score, 
           :after_remove => :calculate_score
  
  validates_presence_of :text
  
  named_scope :approved,
              :conditions => { :approved => true }
  named_scope :unapproved, 
              :conditions => { :approved => false }
  named_scope :by_score_desc,
              :order => 'score DESC'
  named_scope :by_created_at_desc, 
              :order => 'created_at DESC'
              
  def self.find_by_options(options = {})
    scope = self.scoped({})
    case options[:approval]
      when 'approved' then
        scope = scope.approved
      when 'unapproved' then
        scope = scope.unapproved
    end
    case options[:order]
      when 'score_desc' then
        scope = scope.by_score_desc
      when 'created_at_desc' then
        scope = scope.by_created_at_desc
    end
    scope
  end
            
  def lines
    text.split("\n")
  end
      
  def number
    '#%04d' % id
  end
  
  private
  
    def calculate_score(vote)
      update_attribute(:score, self.score += vote.vote_type)
    end
end
