class CreateDispatches < ActiveRecord::Migration[7.0]
  def change
    create_table :dispatches, id: false, primary_key: :uuid do |t|
      t.string :uuid
      t.string :name
      t.boolean :executed, default: false
      t.boolean :error, default: false

      t.timestamps
    end
  end
end
