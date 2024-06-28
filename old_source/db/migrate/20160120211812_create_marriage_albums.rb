# frozen_string_literal: true

class CreateMarriageAlbums < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_albums do |t|
      t.integer :marriage_id
      t.string :name, limit: 14
    end
  end
end
