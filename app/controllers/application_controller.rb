# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  private
  
    def current_user_session
      @current_user_session ||= UserSession.find
    end
    
    def current_user
      @current_user ||= current_user_session.record if current_user_session
    end
  
    def require_user
      if not current_user
        store_request
        flash[:notice] = 'You must be logged in to access this page.'
        redirect_to new_user_session_path
      end
    end
    
    def require_no_user
      if current_user
        store_request
        flash[:notice] = 'You must be logged out to access this page.'
        redirect_to admin_users_path
      end
    end
    
    def store_request
      session[:return_to] = request.request_uri
    end
    
    def redirect_to_back_or_default(default)
      redirect_to session[:return_to] || default
      session[:return_to] = nil
    end
end
