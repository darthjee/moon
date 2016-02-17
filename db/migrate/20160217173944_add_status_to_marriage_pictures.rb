class AddStatusToMarriagePictures < ActiveRecord::Migration
  def change
    add_column :marriage_pictures, :status, :string, default: :display, limit: 10
    add_column :marriage_albums, :status, :string, default: :display, limit: 10
  end
end
