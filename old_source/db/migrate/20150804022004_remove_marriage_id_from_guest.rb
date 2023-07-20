# frozen_string_literal: true

class RemoveMarriageIdFromGuest < ActiveRecord::Migration[4.2]
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
