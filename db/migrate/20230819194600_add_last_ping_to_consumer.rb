class AddLastPingToConsumer < ActiveRecord::Migration[7.0]
  def change
    add_column :consumers, :last_ping, :timestamp
  end
end
