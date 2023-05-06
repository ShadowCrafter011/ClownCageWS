class ApplicationController < ActionController::Base
    def aylin_count
        redis = Redis.new(host: "localhost")
        (redis.get("aylin_count") || 0).to_i
    end

    def require_admin!
        session_token_status == "admin"
    end

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
        if data[1].to_i < Time.now.to_i || data[2] != request.ip
            cookies.delete :_session_token
            return nil
        end
        data[0]
    end
end
