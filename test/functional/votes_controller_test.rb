require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  test 'create should create a vote with a vote type and be associated with the quote' do
    post :create, { :quote_id => quotes(:quote1).id, :vote_type => Vote::VOTE_TYPES[:up] }
    assert_redirected_to quotes_path
    assert_equal 'Up vote has been cast.', flash[:info]
  end
end
