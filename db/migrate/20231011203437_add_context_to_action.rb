class AddContextToAction < ActiveRecord::Migration[7.0]
  def change
    add_column :actions, :context, :string, default: :main
  end
end
