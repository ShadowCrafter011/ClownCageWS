class ApplicationController < ActionController::Base    
    def require_admin!
        unless session_token_status == "admin"
            render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
        end
    end

    def is_admin?
        session_token_status == "admin"
    end
    helper_method :is_admin?

    def require_login!
        redirect_to clown_path unless logged_in?
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
