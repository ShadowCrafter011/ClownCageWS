class AddLockedToConsumer < ActiveRecord::Migration[7.0]
  def change
    add_column :consumers, :locked, :boolean
  end
end
