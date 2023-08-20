class RemoveConsumersActionsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :consumers_actions
    add_column :urls, :url_from, :string
  end
end
