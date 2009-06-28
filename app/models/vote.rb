class Vote < ActiveRecord::Base
  belongs_to :quote
  
  VOTE_TYPES = { :up => 1, :down => -1 }
  
  validates_inclusion_of :vote_type, :in => VOTE_TYPES.values
  
  named_scope :up,   :conditions => { :vote_type => VOTE_TYPES[:up] }
  named_scope :down, :conditions => { :vote_type => VOTE_TYPES[:down] }
  
  def humanised_vote_type
    case vote_type
      when 1 then 
        'Up'
      when -1
        'Down'
    end
  end
  
  def characterised_vote_type
    case vote_type
      when 1 then 
        '&uarr;'
      when -1 then 
        '&darr;'
    end
  end
end
