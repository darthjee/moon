class CreateMarriageStore < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_stores do |t|
      t.string :name
      t.string :image_url
      t.string :url
      t.timestamps
    end
  end
end
