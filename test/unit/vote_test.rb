require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'should not save without vote type' do
    @vote = Vote.new(:vote_type => 'invalid')
    assert ! @vote.save
  end
  
  test 'named_scope up should be a collection of votes with type up' do
    @votes = Vote.up
    @votes.each do |vote|
      assert_equal Vote::VOTE_TYPES[:up], vote.vote_type
    end
  end
  
  test 'named_scope down should be a collection of votes with type down' do
    @votes = Vote.down
    @votes.each do |vote|
      assert_equal Vote::VOTE_TYPES[:down], vote.vote_type
    end
  end
end
