class CreateMarriageGuests < ActiveRecord::Migration
  def change
    create_table :marriage_guests do |t|
      t.integer :marriage_id
      t.integer :invite_id
      t.string :name
      t.string :presence
      t.timestamps
    end
  end
end
