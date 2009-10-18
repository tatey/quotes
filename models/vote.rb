class Vote < Sequel::Model
  plugin :timestamps, :update_on_create => true
  plugin :validation_helpers
  
  VOTE_TYPES = { :up => 1, :down => -1 }
  
  many_to_one :quote  
  
  def validate
    validates_includes VOTE_TYPES.values, :vote_type
  end
end
