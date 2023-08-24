class ChangeConsumerActionRelation < ActiveRecord::Migration[7.0]
  def change
    rename_table :action_consumers, :action_data
    add_column :action_data, :data, :text
    add_column :action_data, :enabled, :boolean, default: false
    add_column :actions, :default_data, :text
    remove_column :actions, :action, :text
    remove_column :actions, :on, :string
  end
end
