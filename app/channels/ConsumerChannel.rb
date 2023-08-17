class ConsumerChannel < ApplicationCable::Channel
    def subscribed
        stream_from "non_consumer_#{uuid}"
    end

    def ping data
        consumer = Consumer.find data["uuid"]
        
        if data["active"]
            consumer.update last_ping: Time.now, last_active_ping: Time.now
        else
            consumer.update last_ping: Time.now
        end
    end

    def identify data
        stream_from "consumer_#{data["uuid"]}"
    end

    def create_consumer
        new_consumer = Consumer.create
        ActionCable.server.broadcast "non_consumer_#{uuid}", { type: "uuid_payload", uuid: new_consumer.uuid }
    end
end