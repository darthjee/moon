class CreateMarriageLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_locations do |t|
      t.string :name
      t.string :address
      t.string :map_url
      t.string :instruction
      t.integer :marriage_id

      t.timestamps
    end
  end
end
