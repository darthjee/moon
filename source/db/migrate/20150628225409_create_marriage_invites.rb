class CreateMarriageInvites < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_invites do |t|
      t.integer :marriage_id
      t.string :label
      t.integer :invites
      t.integer :expected
      t.integer :confirmed
      t.timestamps
    end
  end
end
