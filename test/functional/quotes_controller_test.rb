require 'test_helper'

class QuotesControllerTest < ActionController::TestCase
  test 'index should be a collection of quotes' do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotes)
  end
  
  test 'show should be a quote' do
    get :show, { :id => 1 }
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'new should be a newly instantiated quote' do
    get :new
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'create should save a quote and redirect to show' do
    post :create, { :quote => { :text => 'So the other day I was hanging out' } }
    assert_redirected_to quotes_path
    assert_equal 'Quote created', flash[:info]
  end
  
  test 'edit should be a quote' do
    get :edit, { :id => 2 }
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'update should update attributes on a quote' do
    post :update, { :id => 2, :quote => { :text => 'It was a weird dream, and' } }
    assert_redirected_to assigns(:quote)
    assert_equal 'Quote updated', flash[:info]
  end
  
  test 'destroy should destroy a quote' do
    delete :destroy, { :id => 3 }
    assert_redirected_to quotes_path
  end
end
