class AddDescriptionToAction < ActiveRecord::Migration[7.0]
  def change
    add_column :actions, :description, :text
  end
end
