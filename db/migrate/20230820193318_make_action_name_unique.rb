class MakeActionNameUnique < ActiveRecord::Migration[7.0]
  def change
    add_index :actions, :name, unique: true
  end
end
