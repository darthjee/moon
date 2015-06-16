class CreateMarriageEvent < ActiveRecord::Migration
  def change
    create_table :marriage_events do |t|
      t.time :time
      t.integer :marriage_id
      t.string :description
      t.timestamps
    end
  end
end
