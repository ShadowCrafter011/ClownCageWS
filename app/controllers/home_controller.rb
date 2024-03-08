require "rake"

Rake::Task.clear
Rails.application.load_tasks

class HomeController < ApplicationController
  def index
    redirect_to consumers_path if logged_in?
  end

  def test_reset
    `git pull`
    Rake::Task["test:reset"].invoke
  end

  def idlist
    @plugins = Action::plugins.order(id: :asc)
    @commands = Action::dispatched.order(id: :asc)
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

    return redirect_to consumers_path if logged_in?
    redirect_to root_path
  end

  def logout
    cookies.delete :_session_token
    redirect_to root_path
  end

  def download
    redirect_to "https://github.com/ShadowCrafter011/ClownCage/releases/download/2.0.0/ClownCage.zip", allow_other_host: true
  end

  private
  def set_session_token value
    salt = SecureRandom.base58 64
    expires = 2.weeks.from_now
    cookies.encrypted["_session_token"] = { value: "#{value}-#{expires.to_i}-#{salt}", expires: expires }
  end
end
