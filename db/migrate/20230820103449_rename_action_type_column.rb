class RenameActionTypeColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :actions, :type, :action_type
  end
end
