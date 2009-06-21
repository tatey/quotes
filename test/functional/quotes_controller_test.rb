require 'test_helper'

class QuotesControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotes)
  end
  
  test 'should show a quote' do
    get :show, { :id => 1 }
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'should get new' do
    get :new
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'create should save a quote and redirect to show' do
    post :create, { :quote => { :text => 'So the other day I was hanging out' } }
    assert_redirected_to quotes_path
    assert_equal "Quote #{assigns(:quote).number} has been created.", flash[:info]
  end
end
