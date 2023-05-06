class ApplicationController < ActionController::Base
    def aylin_count
        redis = Redis.new(host: "localhost")
        (redis.get("aylin_count") || 0).to_i
    end

    def require_login!
        redirect_to root_path unless session[:logged_id] == true
      end
end
