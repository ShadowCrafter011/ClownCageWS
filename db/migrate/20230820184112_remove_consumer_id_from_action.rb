class RemoveConsumerIdFromAction < ActiveRecord::Migration[7.0]
  def change
    remove_column :actions, :consumer_id
  end
end
