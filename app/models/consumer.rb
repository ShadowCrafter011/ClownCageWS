class Consumer < ApplicationRecord
    self.primary_key = :uuid

    before_validation do 
        self.uuid ||= SecureRandom.uuid
    end

    before_save do
        self.updated_at = Time.now
    end

    def self.ping change_uuid_channel, data
        unless Consumer.exists?(data["uuid"])
            consumer = Consumer.create
            ActionCable.server.broadcast(change_uuid_channel, { type: "change_uuid", uuid: consumer.uuid })
        else
            consumer = Consumer.find(data["uuid"])
        end

        consumer.update num_tabs: data["num_tabs"], has_active: data["has_active"]

        ActionCable.server.broadcast("web_consumer_#{consumer.uuid}", { action: "reload_consumer_frame" })
    end

    def last_ping
        self.updated_at
    end

    def online?
        self.updated_at + 4.seconds > Time.now
    end
end
