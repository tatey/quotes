class User < ActiveRecord::Base
  acts_as_authentic do |opt|
    opt.login_field :email
  end
  
  validates_format_of   :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :first_name, :last_name
end
