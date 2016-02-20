class ChangeMarriageLocationsMapUrl < ActiveRecord::Migration
  def up
    change_column :marriage_locations, :map_url, :text
  end

  def down
    change_column :marriage_locations, :map_url, :string
  end
end
