class RemoveLastPingFromConsumer < ActiveRecord::Migration[7.0]
  def change
    remove_column :consumers, :last_ping
  end
end
