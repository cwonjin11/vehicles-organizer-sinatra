class AddColumnModel < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :model, :string
  end
end
