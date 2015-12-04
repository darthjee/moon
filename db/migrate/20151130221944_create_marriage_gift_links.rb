class CreateMarriageGiftLinks < ActiveRecord::Migration
  def change
    create_table :marriage_gift_links do |t|
      t.integer :gift_id
      t.integer :store_list_id
      t.string :url
      t.timestamps
    end
  end
end
