class CreateMarriageStoreList < ActiveRecord::Migration
  def change
    create_table :marriage_store_lists do |t|
      t.integer :store_id
      t.string :url
      t.timestamps
    end
  end
end
