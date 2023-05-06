class WebChannel < ApplicationCable::Channel
    def subscribed
        stream_from "web_channel"
    end
end