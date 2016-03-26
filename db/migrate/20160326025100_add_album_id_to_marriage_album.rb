class AddAlbumIdToMarriageAlbum < ActiveRecord::Migration
  def change
    add_column :marriage_albums, :album_id, :integer
  end
end
