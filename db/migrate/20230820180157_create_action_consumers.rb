class CreateActionConsumers < ActiveRecord::Migration[7.0]
  def change
    create_table :action_consumers do |t|
      t.references :action, null: false, foreign_key: true
      t.references :consumer, type: :string, null: false, foreign_key: { primary_key: :uuid }
    end
  end
end
