class CreateExtensions < ActiveRecord::Migration[7.0]
  def change
    create_table :extensions, id: false, primary_key: :uuid do |t|
      t.string :uuid, null: false
      t.string :nickname
      t.timestamp :last_ping
      t.timestamp :last_active_ping

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
