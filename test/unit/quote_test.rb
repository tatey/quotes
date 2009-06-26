require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  def setup
    @quote = quotes(:quote1)
  end
  
  test 'text attribute writer should strip leading and trailing whitespace' do
    string_with_whitespace = '    white space   '
    @quote.text = string_with_whitespace
    assert_not_equal string_with_whitespace, @quote.text
    assert ! @quote.text.first.blank?
    assert ! @quote.text.last.blank?
  end
    
  test 'should not save without text' do
    @quote.text = nil
    assert ! @quote.save
  end
  
  test 'named_scope approved should be a collection of approved quotes' do
    Quote.approved.each do |quote|
      assert quote.approved?
    end
  end
  
  test 'named_scope unapproved should be a collection of unapproved quotes' do
    Quote.unapproved.each do |quote|
      assert ! quote.approved?
    end
  end
  
  test 'lines should be an array of lines with no duplicate colours' do
    assert_equal 3, @quote.lines.size
    assert_equal 'Nick1:', @quote.lines[0].nick
    assert_equal 'colour_0', @quote.lines[0].colour
    assert_equal 'Nick1:', @quote.lines[1].nick
    assert_equal 'colour_0', @quote.lines[1].colour
    assert_equal 'Nick2:', @quote.lines[2].nick
    assert_equal 'colour_1', @quote.lines[2].colour
  end
  
  test 'lines should be nil when text is undefined' do
    @quote.text = nil
    assert_nil @quote.lines
  end
      
  test 'score should be 2 when associated with 4 up votes and 2 down votes' do
    @quote.votes.delete_all
    @quote.update_attribute(:score, 0)
    4.times { @quote.votes << Vote.create(:vote_type => Vote::VOTE_TYPES[:up]) }
    2.times { @quote.votes << Vote.create(:vote_type => Vote::VOTE_TYPES[:down]) }
    assert_equal 2, @quote.score
  end
    
  test 'number should be a formatted string' do
    assert_equal '#0001', @quote.number
  end
end
