class AddVisibleTabsToConsumer < ActiveRecord::Migration[7.0]
  def change
    add_column :consumers, :visible_tabs, :bigint
  end
end
