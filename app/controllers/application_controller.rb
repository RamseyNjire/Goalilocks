class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def login!(user)
        @current_user = user
        session[:session_token] = user.session_token
    end

    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logout!
        current_user.try(:reset_session_token!)
        session[:session_token] = nil
    end

    def require_current_user!
        redirect_to new_session_url if current_user.nil?
    end

    def require_no_current_user!
        redirect_to user_url(current_user) unless current_user.nil?
    end

    def require_resource_owner(resource)
        redirect_to new_session_url unless ((resource.user_id || resource.creator_id) == current_user.id)
    end

end
