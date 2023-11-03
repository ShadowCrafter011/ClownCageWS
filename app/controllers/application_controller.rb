class ApplicationController < ActionController::Base    
    def require_admin!
        # TODO: Remove "public" for final release
        redirect_to admin_path unless session_token_status == "admin" || session_token_status == "public"
    end

    def is_admin?
        # TODO: Remove "public" for final release
        session_token_status == "admin" || session_token_status == "public"
    end
    helper_method :is_admin?

    def require_login!
        redirect_to admin_path unless logged_in?
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
