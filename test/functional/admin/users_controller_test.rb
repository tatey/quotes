require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  def setup
    login_user
  end
  
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  
  test 'should get new' do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end
  
  test 'create should save a user and redirect to admin_users_path' do
    post :create, { :user => { :email => 'foo@bar.com', :first_name => 'Foo', :last_name => 'bar', :password => 'secret', :password_confirmation => 'secret' } }
    assert_redirected_to admin_users_path
    assert_equal 'Foo has been created.', flash[:info]
  end
  
  test 'should get edit' do
    get :edit, { :id => users(:tate_johnson).id }
    assert_response :success
    assert_equal 'Tate', assigns(:user).first_name
  end
  
  test 'update should update attributes on a user' do
    put :update, { :id => users(:tate_johnson).id, :user => { :email => 'foobar@bar.com' } }
    assert_redirected_to admin_users_path
    assert_equal 'Tate has been updated.', flash[:info]
  end
  
  test 'destroy should destroy a user' do
    delete :destroy, { :id => users(:tate_johnson).id }
    assert_redirected_to admin_users_path
    assert_equal 'Tate has been destroyed.', flash[:info]
  end
end
