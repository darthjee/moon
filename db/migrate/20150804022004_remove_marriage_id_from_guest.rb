class RemoveMarriageIdFromGuest < ActiveRecord::Migration
  def up
    remove_column :marriage_guests, :marriage_id
  end

  def down
    add_column :marriage_guests, :marriage_id, :integer
    Marriage::Guest.find_each do |guest|
      guest.marriage_id = guest.invite.try(:marriage_id)
    end
  end
end
