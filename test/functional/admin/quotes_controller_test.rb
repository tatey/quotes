require 'test_helper'

class Admin::QuotesControllerTest < ActionController::TestCase
  def setup
    login_user
  end
  
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotes)
  end
  
  test 'should get edit' do
    get :edit, { :id => quotes(:quote2).id }
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'update should update attributes on a quote' do
    post :update, { :id => quotes(:quote2).id, :quote => { :text => 'It was a weird dream, and' } }
    assert_redirected_to admin_quotes_path
    assert_equal "Quote #{assigns(:quote).number} has been updated.", flash[:info]
  end
  
  test 'destroy should destroy a quote' do
    delete :destroy, { :id => quotes(:quote3).id }
    assert_redirected_to admin_quotes_path
    assert_equal "Quote #{assigns(:quote).number} has been destroyed.", flash[:info]
  end
end
