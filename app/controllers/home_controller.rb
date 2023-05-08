class HomeController < ApplicationController
  def index
    redirect_to commands_path if logged_in?
  end

  def time_zone
    salt = SecureRandom.base58 64
    cookies.encrypted["time_zone"] = { value: "#{params[:t]}-#{salt}", expires: 1.week.from_now }
    return_to = url_from(params[:p]) || root_path
    redirect_to return_to
  end

  def login
    case params[:password]
    when ENV["ADMIN_PASSWORD"]
      set_session_token "admin"

    when ENV["PUBLIC_PASSWORD"]
      set_session_token "public"

    else
      session[:error] = 1
      return redirect_to root_path
    end

    return redirect_to commands_path if logged_in?
    redirect_to root_path
  end

  def logout
    cookies.delete :_session_token
    redirect_to root_path
  end

  private
  def set_session_token value
    salt = SecureRandom.base58 64
    expires = 2.weeks.from_now
    cookies.encrypted["_session_token"] = { value: "#{value}-#{expires.to_i}-#{salt}", expires: expires }
  end 
end
