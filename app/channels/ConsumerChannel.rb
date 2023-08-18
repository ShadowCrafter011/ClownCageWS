class ConsumerChannel < ApplicationCable::Channel
    def subscribed
        stream_from "non_consumer_#{uuid}"
    end

    def ping data
        Consumer::ping data
    end

    def identify data
        stream_from "consumer_#{data["uuid"]}"
    end

    def create_consumer
        new_consumer = Consumer.create
        ActionCable.server.broadcast "non_consumer_#{uuid}", { type: "uuid_payload", uuid: new_consumer.uuid }
    end
end