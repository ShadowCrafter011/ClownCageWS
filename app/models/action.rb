class Action < ApplicationRecord
  has_many :action_data, dependent: :destroy
  has_many :consumers, through: :action_data
  has_many :urls

  def dispatch consumer_uuid
    action_datum = ActionDatum::find_or_create_by consumer_id: consumer_uuid, action_id: self.id
    return if action_datum.consumer.locked
    ActionCable.server.broadcast("consumer_#{consumer_uuid}", {
      name: self.name,
      type: self.action_type,
      data: JSON.parse(action_datum.get_data)
    })
  end

  def revoke_plugin consumer_uuid
    ActionCable.server.broadcast("consumer_#{consumer_uuid}", {
      name: self.name,
      type: "revoke_plugin"
    })
  end

  def enabled? consumer_uuid
    action_datum = ActionDatum::find_or_create_by consumer_id: consumer_uuid, action_id: self.id
    action_datum.present? && action_datum.enabled
  end

  def plugin?
    self.action_type == "plugin"
  end

  def dispatched?
    self.action_type == "dispatched"
  end

  def self.plugins
    Action.where(action_type: "plugin").order(created_at: :asc)
  end

  def self.dispatched
    Action.where(action_type: "dispatched").order(created_at: :asc)
  end
end
