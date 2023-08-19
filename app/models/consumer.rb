class Consumer < ApplicationRecord
    self.primary_key = :uuid

    before_validation do 
        self.uuid ||= SecureRandom.uuid
    end

    before_create { self.last_ping = Time.now }

    def self.ping change_uuid_channel, data
        unless Consumer.exists?(data["uuid"])
            consumer = Consumer.create
            ActionCable.server.broadcast(change_uuid_channel, { type: "change_uuid", uuid: consumer.uuid })
        else
            consumer = Consumer.find(data["uuid"])
        end

        consumer.update num_tabs: data["num_tabs"], has_active: data["has_active"], last_ping: Time.now

        ActionCable.server.broadcast("web_consumer_#{consumer.uuid}", { action: "reload_consumer_frame" })
    end

    def online?
        self.last_ping + 4.seconds > Time.now
    end
end
