class CreateMarriageMarriages < ActiveRecord::Migration
  def change
    create_table :marriage_marriages do |t|
      t.date :date
      t.timestamps
    end
  end
end
