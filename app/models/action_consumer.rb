class ActionConsumer < ApplicationRecord
  belongs_to :action
  belongs_to :consumer
end
