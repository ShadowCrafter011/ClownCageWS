class ApplicationController < ActionController::Base    
    def require_admin!
        redirect_to root_path unless session_token_status == "admin"
    end

    def is_admin?
        session_token_status == "admin"
    end
    helper_method :is_admin?

    def require_login!
        redirect_to root_path unless logged_in?
    end

    def logged_in?
        token = session_token_status
        token == "admin" || token == "public"
    end

    def session_token_status
        return nil unless cookies.encrypted["_session_token"].present?
        data = cookies.encrypted["_session_token"].split("-")
        if data[1].to_i < Time.now.to_i
            cookies.delete :_session_token
            return nil
        end
        data[0]
    end
end
