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
    end

    def last_ping
        self.updated_at
    end
end
