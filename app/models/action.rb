class Action < ApplicationRecord
  has_many :action_consumers
  has_many :consumers, through: :action_consumers
  has_many :urls

  def dispatch to
    ActionCable.server.broadcast("consumer_#{to.uuid}", {
      name: self.name,
      type: self.action_type,
      on: self.on,
      action: self.action
    })
  end

  def self.plugins
    Action.where(action_type: "plugin").order(created_at: :asc)
  end

  def self.dispatched
    Action.where(action_type: "dispatched").order(created_at: :asc)
  end
end
