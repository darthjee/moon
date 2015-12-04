class CreateMarriageStore < ActiveRecord::Migration
  def change
    create_table :marriage_stores do |t|
      t.string :name
      t.string :image_url
      t.string :url
      t.timestamps
    end
  end
end
