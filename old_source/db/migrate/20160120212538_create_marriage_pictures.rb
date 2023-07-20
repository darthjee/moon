# frozen_string_literal: true

class CreateMarriagePictures < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_pictures do |t|
      t.integer :album_id
      t.string :name, limit: 14
      t.string :url
      t.string :snap_url
    end
  end
end
