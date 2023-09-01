class ActionDatum < ApplicationRecord
  belongs_to :action
  belongs_to :consumer

  def get_data
    self.data || self.action.default_data
  end

  def enabled?
    self.enabled
  end

  def toggle
    self.update enabled: !self.enabled

    return if JSON.parse(self.get_data)[:on] == "load"

    if self.enabled?
      self.action.dispatch self.consumer.uuid
    else
      self.action.revoke_plugin self.consumer.uuid
    end
  end

  def self.find_or_create_by consumer_id: nil, action_id: nil
    ActionDatum.find_by(consumer_id: consumer_id, action_id: action_id) || ActionDatum.create(consumer_id: consumer_id, action_id: action_id)
  end
end
