class AddNumTabsAndActive < ActiveRecord::Migration[7.0]
  def change
    add_column :consumers, :num_tabs, :bigint
    add_column :consumers, :has_active, :boolean
    remove_column :consumers, :last_active_ping
  end
end
