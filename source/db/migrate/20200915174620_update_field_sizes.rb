class UpdateFieldSizes < ActiveRecord::Migration[5.2]
  def up
    change_column :marriage_albums, :name, :string, limit: 30
    add_column :marriage_albums, :order, :integer, limit: 1, null: false, default: 0
  end

  def down
    change_column :marriage_albums, :name, :string, limit: 14
    remove_column :marriage_albums, :order
  end
end
