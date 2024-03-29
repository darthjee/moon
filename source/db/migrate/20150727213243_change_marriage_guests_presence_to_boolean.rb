# frozen_string_literal: true

class ChangeMarriageGuestsPresenceToBoolean < ActiveRecord::Migration[4.2]
  def up
    rename_column :marriage_guests, :presence, :old_presence
    add_column :marriage_guests, :presence, :boolean
    Marriage::Guest.unscoped.all.each do |guest|
      guest.presence = guest.old_presence?
    end
    remove_column :marriage_guests, :old_presence
  end

  def down
    rename_column :marriage_guests, :presence, :old_presence
    add_column :marriage_guests, :presence, :string
    Marriage::Guest.unscoped.all.each do |guest|
      guest.presence = guest.old_presence?
    end
    remove_column :marriage_guests, :old_presence
  end
end
