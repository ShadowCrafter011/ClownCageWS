class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :action_type
      t.references :folder, null: true, foreign_key: true
    end

    add_column :actions, :folder_id, :bigint, foreign_key: true
  end
end
