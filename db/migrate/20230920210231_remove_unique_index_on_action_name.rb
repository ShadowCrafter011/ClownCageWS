class RemoveUniqueIndexOnActionName < ActiveRecord::Migration[7.0]
  def change
    remove_index :actions, name: "index_actions_on_name"
  end
end
