class ActionDatum < ApplicationRecord
  belongs_to :action
  belongs_to :consumer

  after_update do
    if self.enabled? && self.action.plugin? && !self.consumer.locked && !self.load_plugin?
      self.action.redispatch self.consumer.uuid
    end
  end

  def get_data
    self.data || self.action.default_data
  end

  def set_data data
    JSON.parse(data)
    self.update data: data
    true
  rescue JSON::ParserError, TypeError => e
    false
  end

  def enabled?
    self.enabled
  end

  def toggle
    self.update enabled: !self.enabled

    return if self.load_plugin?

    if self.enabled?
      self.action.dispatch self.consumer.uuid
    else
      self.action.revoke_plugin self.consumer.uuid
    end
  end

  def load_plugin?
    self.action.plugin? && JSON.parse(self.get_data)["on"] == "load"
  end

  def self.find_or_create_by consumer_id: nil, action_id: nil
    ActionDatum.find_by(consumer_id: consumer_id, action_id: action_id) || ActionDatum.create(consumer_id: consumer_id, action_id: action_id)
  end
end
