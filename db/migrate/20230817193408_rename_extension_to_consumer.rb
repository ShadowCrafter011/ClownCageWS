class RenameExtensionToConsumer < ActiveRecord::Migration[7.0]
  def change
    rename_table :extensions, :consumers
  end
end
