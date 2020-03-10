class MigrateEventLocation < ActiveRecord::Migration[4.2]
  def up
    rename_column :marriage_events, :location, :location_name
    add_column :marriage_events, :location_id, :integer

    Marriage::Event.find_each do |event|
      location = Marriage::Location.create(
        name: event.location_name,
        address: event.address,
        marriage_id: event.marriage_id
      )
      event.update(location: location)
    end

    remove_column :marriage_events, :location_name
    remove_column :marriage_events, :address
  end

  def down
    add_column :marriage_events, :address, :string
    add_column :marriage_events, :location_name, :string

    Marriage::Event.find_each do |event|
      event.update(
        location_name: event.location.name,
        address: event.location.address
      )
      event.location.destroy
    end

    remove_column :marriage_events, :location_id
    rename_column :marriage_events, :location_name, :location
  end
end
