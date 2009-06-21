require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end
  
  test 'should create user session' do
    post :create, :user_session => { :email => 'tate@tatey.com', :password => 'secret' }
    assert user_session = UserSession.find
    assert_equal users(:tate_johnson), user_session.user
    assert_redirected_to admin_users_path
    assert_equal 'Login successful!', flash[:info]
  end
  
  test 'should destroy user session' do
    login_user
    
    delete :destroy
    assert_nil UserSession.find
    assert_redirected_to new_user_session_path
    assert_equal 'Logout successful!', flash[:info]
  end
end
