class ChangeMarriageGuestsPresenceToBoolean < ActiveRecord::Migration
  def up
    rename_column :marriage_guests, :presence, :old_presence
    add_column :marriage_guests, :presence, :boolean
    Marriage::Guest.all.each do |guest|
      guest.presence = guest.old_presence?
    end
    remove_column :marriage_guests, :old_presence
  end

  def down
    rename_column :marriage_guests, :presence, :old_presence
    add_column :marriage_guests, :presence, :string
    Marriage::Guest.all.each do |guest|
      guest.presence = guest.old_presence?
    end
    remove_column :marriage_guests, :old_presence
  end
end
