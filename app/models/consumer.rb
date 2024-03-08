class Consumer < ApplicationRecord
    self.primary_key = :uuid

    has_many :action_data, dependent: :destroy
    has_many :actions, through: :action_data
    has_many :urls

    before_validation do 
        self.uuid ||= SecureRandom.uuid
    end

    after_create do
        ActionCable.server.broadcast("web_navbar", { action: "reload_navbar" })
    end

    before_create { self.last_ping = Time.now }
    
    def dispatch_action action_id
        if (action = Action.find(action_id)).present?
            action.dispatch self
        end
        action.present?
    end

    def dispatch_plugins with_load_plugins: true
        self.action_data.each do |action_data|
            next unless action_data.action.plugin? && action_data.enabled?
            next if !with_load_plugins && action_data.load_plugin? 
            action_data.action.dispatch self.uuid
        end
    end

    def toggle_lock
        self.update locked: !self.locked
        if self.locked
            self.revoke_plugins
        else
            self.dispatch_plugins with_load_plugins: false
        end
    end

    def revoke_plugins
        active_plugin_data = ActionDatum.where(consumer_id: self.uuid, enabled: true).filter do |action_datum|
            action_datum.action.plugin? && !action_datum.load_plugin?
        end
        active_plugin_data.each do |plugin_datum|
            plugin_datum.action.revoke_plugin self.uuid
        end
    end

    def online?
        self.last_ping + 2.seconds > Time.now
    end

    def self.ping change_uuid_channel, data
        unless Consumer.exists?(data["uuid"])
            consumer = Consumer.create
            ActionCable.server.broadcast(change_uuid_channel, { type: "change_uuid", uuid: consumer.uuid })
        else
            consumer = Consumer.find(data["uuid"])
        end

        consumer.update num_tabs: data["num_tabs"], visible_tabs: data["visible_tabs"], has_active: data["has_active"], last_ping: Time.now

        ActionCable.server.broadcast("web_consumer_#{consumer.uuid}", { action: "reload_consumer_frame" })
    end
end
