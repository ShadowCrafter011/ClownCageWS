class ChangeActionForeignKeySetup < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :actions, :consumers

    create_table :consumers_actions, id: false do |t|
      t.references :consumer, type: :string, null: false, foreign_key: { primary_key: :uuid }
      t.references :action, null: false, foreign_key: true
    end

    add_reference :urls, :consumer, type: :string, null: false, foreign_key: { primary_key: :uuid }
  end
end
