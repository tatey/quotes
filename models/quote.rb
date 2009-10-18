class Quote < Sequel::Model
  plugin :timestamps, :update_on_create => true
  plugin :validation_helpers

  one_to_many :votes, :after_add => :calculate_votes_count
  
  def_dataset_method(:by_recent) do
    order :created_at.desc
  end
  
  def_dataset_method(:by_highest_votes_count) do
    order :votes_count.desc
  end
  
  def lines
    text.split("\n").inject([]) do |lines, line|
      lines << Line.new(line)
      lines
    end
  end
  
  def number
    '#%04d' % id
  end
  
  def validate
    validates_min_length 10, :text
    validates_presence :text
  end
                    
  private
  
    def calculate_votes_count(vote)
      update :votes_count => votes_count + vote.vote_type
    end
end
