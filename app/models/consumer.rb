class Consumer < ApplicationRecord
    self.primary_key = :uuid

    before_validation do 
        self.uuid ||= SecureRandom.uuid
    end

    before_save do
        self.updated_at = Time.now
    end

    def self.ping data
        consumer = Consumer.find(data["uuid"])
        consumer.update num_tabs: data["num_tabs"], has_active: data["has_active"]

        ActionCable.server.broadcast("web_consumer_#{consumer.uuid}", { action: "reload_consumer_frame" })
    end

    def online?
        self.updated_at + 4.seconds > Time.now
    end
end
