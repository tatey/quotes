require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:tate_johnson)
  end
  
  test 'user should not save with invalid email' do
    @user.email = 'invalid'
    assert ! @user.save
  end
  
  test 'user should not save without first_name' do
    @user.first_name = ''
    assert ! @user.save
  end
  
  test 'user should not save without last_name' do
    @user.last_name = ''
    assert ! @user.save
  end
end
