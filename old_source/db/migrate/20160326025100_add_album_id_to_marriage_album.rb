# frozen_string_literal: true

class AddAlbumIdToMarriageAlbum < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_albums, :album_id, :integer
  end
end
