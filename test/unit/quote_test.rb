require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  def setup
    @quote = quotes(:quote1)
  end
    
  test 'should not save without text' do
    @quote.text = nil
    assert ! @quote.save
  end
  
  test 'lines should be an array of lines' do
    assert_equal 'Line 1', @quote.lines.first
    assert_equal 3, @quote.lines.size
  end
  
  test 'score should be 0 when not associated with any votes' do
    @quote.votes.delete_all
    assert_equal 0, @quote.score
  end
  
  test 'score should be 2 when associated with 4 up votes and 2 down votes' do
    @quote.votes.delete_all
    4.times { @quote.votes << Vote.create(:vote_type => Vote::VOTE_TYPES[:up]) }
    2.times { @quote.votes << Vote.create(:vote_type => Vote::VOTE_TYPES[:down]) }
    assert_equal 2, @quote.score
  end
end
