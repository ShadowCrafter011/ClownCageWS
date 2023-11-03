class ConsumerChannel < ApplicationCable::Channel
    def subscribed
        stream_from "non_consumer_#{uuid}"
    end

    def ping data
        Consumer::ping "non_consumer_#{uuid}", data
    end

    def identify data
        if (consumer = Consumer.find_by(uuid: data["uuid"])).present?
            stream_from "consumer_#{data["uuid"]}"
            consumer.dispatch_plugins
        else
            new_consumer = Consumer.create
            ActionCable.server.broadcast "non_consumer_#{uuid}", { type: "change_uuid", uuid: new_consumer.uuid }
        end
    end

    def executed_action data
        Dispatch.find(data["callback_uuid"]).execute
    end

    def error data
        Dispatch.find(data["callback_uuid"]).error_happened
    end
end