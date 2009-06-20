class Vote < ActiveRecord::Base
  belongs_to :quote
  
  VOTE_TYPES = { :up => 1, :down => 2 }
  
  validates_inclusion_of :vote_type, :in => VOTE_TYPES.values
  
  named_scope :up,   :conditions => { :vote_type => VOTE_TYPES[:up] }
  named_scope :down, :conditions => { :vote_type => VOTE_TYPES[:down] }
end
