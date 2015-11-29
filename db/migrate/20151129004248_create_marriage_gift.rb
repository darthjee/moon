class CreateMarriageGift < ActiveRecord::Migration
  def change
    create_table :marriage_gifts do |t|
      t.string :name
      t.string :image_url
      t.string :description
      t.timestamps
    end
  end
end
