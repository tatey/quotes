require 'test_helper'

class QuotesControllerTest < ActionController::TestCase
  test 'should get index with approved quotes when no logged in user' do
    get :index, { :approval => 'unapproved' }
    assert_response :success
    assigns(:quotes).each do |quote|
      assert quote.approved?
    end
  end
  
  test 'should get index with unapproved quotes when logged in user' do
    login_user
    
    get :index, { :approval => 'unapproved' }
    assert_response :success
    assigns(:quotes).each do |quote|
      assert ! quote.approved?
    end
  end
  
  test 'should get index with unapproved_count when unapproved quotes and logged in user' do
    login_user
    
    get :index
    assert_response :success
    assert assigns(:unapproved_count) > 0
  end
  
  test 'should get index without unapproved_count when no unapproved quotes and logged in user' do
    login_user
    
    Quote.unapproved.delete_all
    get :index
    assert_response :success
    assert_nil assigns(:unapproved_count)
  end
  
  test 'should show an approved quote' do
    get :show, { :id => quotes(:approved1) }
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'should not show an unapproved quote' do
    get :show, { :id => quotes(:unapproved) }
    assert_response :missing
    assert_template "#{RAILS_ROOT}/public/404.html"
  end
  
  test 'should get new' do
    get :new
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'create should save an unapproved quote and redirect to quotes_path when no user' do
    post :create, { :quote => { :text => 'Tate: So the other day I was hanging out' } }
    assert ! assigns(:quote).approved?
    assert_redirected_to quotes_path
    assert_equal "Quote #{assigns(:quote).number} has been submitted and is waiting for approval by a moderator.", flash[:info]
  end
  
  test 'create should save an approved quote and redirect to quotes path when user' do
    login_user
    
    post :create, { :quote => { :text => 'Tate: So the other day I was hanging out' } }
    assert assigns(:quote).approved?
    assert_redirected_to quotes_path
    assert_equal "Quote #{assigns(:quote).number} has been submitted.", flash[:info]
  end
  
  test 'should get edit' do
    login_user
    
    get :edit, { :id => quotes(:approved2) }
    assert_response :success
    assert_not_nil assigns(:quote)
  end
  
  test 'update should update attributes on a quote' do
    login_user
    
    put :update, { :id => quotes(:approved2), :quote => { :text => 'Name: It was a weird dream, and' } }
    assert_redirected_to assigns(:quote)
    assert_equal "Quote #{assigns(:quote).number} has been updated.", flash[:info]
  end
  
  test 'destroy should destroy a quote' do
    login_user
    
    delete :destroy, { :id => quotes(:unapproved) }
    assert_redirected_to quotes_path
    assert_equal "Quote #{assigns(:quote).number} has been destroyed.", flash[:info]
  end
  
  test 'user should be logged in for edit, update and destroy' do
    get :edit, { :id => quotes(:approved2) }
    assert_redirected_to new_user_session_path
    
    put :update, { :id => quotes(:approved2) }
    assert_redirected_to new_user_session_path
    
    delete :destroy, { :id => quotes(:approved2) }
    assert_redirected_to new_user_session_path
  end
end
