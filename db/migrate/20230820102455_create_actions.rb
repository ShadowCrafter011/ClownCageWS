class CreateActions < ActiveRecord::Migration[7.0]
  def change
    create_table :actions do |t|
      t.string :name
      t.string :type, default: "plugin"
      t.string :on
      t.text :action
      t.string :consumer

      t.timestamps
    end

    add_reference :actions, :consumer, type: :string, null: false, foreign_key: { primary_key: :uuid }
  end
end
