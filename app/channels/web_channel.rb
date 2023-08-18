class WebChannel < ApplicationCable::Channel
  def subscribed
    stream_from "web_#{params[:room]}"
  end
end
