class AddEditableToAction < ActiveRecord::Migration[7.0]
  def change
    add_column :actions, :editable, :boolean, default: true
  end
end
