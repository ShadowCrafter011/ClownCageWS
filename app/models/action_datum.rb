class ActionDatum < ApplicationRecord
  belongs_to :action
  belongs_to :consumer

  def enabled?
    self.enabled
  end

  def toggle
    self.update enabled: !self.enabled
  end

  def self.find_or_create_by consumer_id: nil, action_id: nil
    ActionDatum.find_by(consumer_id: consumer_id, action_id: action_id) || ActionDatum.create(consumer_id: consumer_id, action_id: action_id)
  end
end
