class ApplicationController < ActionController::Base    
    def aylin_count
        redis = Redis.new(host: "localhost")
        (redis.get("aylin_count") || 0).to_i
    end

    def convert_time time
        time_zone = "America/Los_Angeles"
        time_zone = cookies.encrypted["time_zone"].split("-")[0] if cookies.encrypted["time_zone"].present?
        time.in_time_zone(time_zone)
    end
    helper_method :convert_time

    def require_admin!
        unless session_token_status == "admin"
            render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
        end
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
        if data[1].to_i < Time.now.to_i
            cookies.delete :_session_token
            return nil
        end
        data[0]
    end
end
