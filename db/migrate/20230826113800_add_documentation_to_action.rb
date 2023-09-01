class AddDocumentationToAction < ActiveRecord::Migration[7.0]
  def change
    add_column :actions, :documentation, :text
  end
end
