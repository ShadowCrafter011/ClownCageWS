class HomeController < ApplicationController
  def index
    redirect_to commands_path if session[:logged_in] == true
  end

  def login
    unless params[:password] == ENV["ADMIN_PASSWORD"]
      session[:error] = 1
      return redirect_to root_path
    end
    session[:logged_id] = true
    redirect_to commands_path
  end
end
