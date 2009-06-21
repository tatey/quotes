require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  def setup
    @quote = quotes(:quote1)
  end
    
  test 'should not save without text' do
    @quote.text = nil
    assert ! @quote.save
  end
  
  test 'named_scope approved should be a collection of approved quotes' do
    Quote.approved.each do |quote|
      assert_equal true, quote.approved?
    end
  end
  
  test 'named_scope unapproved should be a collection of unapproved quotes' do
    Quote.unapproved.each do |quote|
      assert_equal false, quote.approved?
    end
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
  
  test 'approve should be true' do
    assert Quote.approved.first.approve   # True if already approved
    assert Quote.unapproved.first.approve # True after updating record
  end
  
  test 'number should be a formatted string' do
    assert_equal '#0001', @quote.number
  end
end
