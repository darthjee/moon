# frozen_string_literal: true

class CreateMarriageStoreList < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_store_lists do |t|
      t.integer :store_id
      t.integer :marriage_id
      t.string :url
      t.timestamps
    end
  end
end
