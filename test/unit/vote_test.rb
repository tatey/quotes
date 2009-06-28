require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'should not save without vote type' do
    assert ! Vote.new(:vote_type => 'invalid').save
  end
  
  test 'named_scope up should be a collection of votes with type up' do
    Vote.up.each do |vote|
      assert_equal Vote::VOTE_TYPES[:up], vote.vote_type
    end
  end
  
  test 'named_scope down should be a collection of votes with type down' do
    Vote.down.each do |vote|
      assert_equal Vote::VOTE_TYPES[:down], vote.vote_type
    end
  end
  
  test 'humanised_vote_type should be english representation of vote_type' do
    assert_equal 'Up', Vote.new(:vote_type => Vote::VOTE_TYPES[:up]).humanised_vote_type
    assert_equal 'Down', Vote.new(:vote_type => Vote::VOTE_TYPES[:down]).humanised_vote_type
  end
  
  test 'characterised_vote_type should be character entity reference representation of vote_type' do
    assert_equal '&uarr;', Vote.new(:vote_type => Vote::VOTE_TYPES[:up]).characterised_vote_type
    assert_equal '&darr;', Vote.new(:vote_type => Vote::VOTE_TYPES[:down]).characterised_vote_type
  end
end
