class CreateMarriageEvent < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_events do |t|
      t.time :time
      t.integer :marriage_id
      t.string :description
      t.timestamps
    end
  end
end
