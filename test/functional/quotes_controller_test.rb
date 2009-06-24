require 'test_helper'

class QuotesControllerTest < ActionController::TestCase
  test 'should get index with approved quotes when no user' do
    get :index, { :approval => 'unapproved' }
    assert_response :success
    assigns(:quotes).each do |quote|
      assert quote.approved
    end
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
    assert_redirected_to assigns(:quote)
    assert_equal "Quote #{assigns(:quote).number} has been created.", flash[:info]
  end
  
  test 'should get edit' do
    login_user
    
    get :edit, { :id => quotes(:quote2).id }
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'update should update attributes on a quote' do
    login_user
    
    put :update, { :id => quotes(:quote2).id, :quote => { :text => 'It was a weird dream, and' } }
    assert_redirected_to assigns(:quote)
    assert_equal "Quote #{assigns(:quote).number} has been updated.", flash[:info]
  end
  
  test 'destroy should destroy a quote' do
    login_user
    
    delete :destroy, { :id => quotes(:quote3).id }
    assert_redirected_to quotes_path
    assert_equal "Quote #{assigns(:quote).number} has been destroyed.", flash[:info]
  end
  
  test 'user should be logged in for edit, update and destroy' do
    get :edit, { :id => quotes(:quote2).id }
    assert_redirected_to new_user_session_path
    
    put :update, { :id => quotes(:quote2).id }
    assert_redirected_to new_user_session_path
    
    delete :destroy, { :id => quotes(:quote2).id }
    assert_redirected_to new_user_session_path
  end
end
