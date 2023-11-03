class RemoveConsumerFromAction < ActiveRecord::Migration[7.0]
  def change
    remove_column :actions, :consumer
  end
end
