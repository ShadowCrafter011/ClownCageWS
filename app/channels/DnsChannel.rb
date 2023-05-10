class DnsChannel < ApplicationCable::Channel
    def subscribed 
        stream_from "dns_channel"

        redis = Redis.new(host: "localhost")
        redis.incr("aylin_count")

        ActionCable.server.broadcast("web_channel", { type: "connect" })
    end

    def unsubscribed
        redis = Redis.new(host: "localhost")
        redis.decr("aylin_count")

        if redis.get("aylin_count").present? || redis.get("aylin_count") == 0
            ActionCable.server.broadcast("web_channel", { type: "disconnect", num_conns: redis.get("aylin_count") })
        end
    end
end