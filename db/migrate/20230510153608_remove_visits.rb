class RemoveVisits < ActiveRecord::Migration[7.0]
  def change
    drop_table :visits
  end
end
