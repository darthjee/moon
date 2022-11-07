# frozen_string_literal: true

class ChangeMarriageLocationsMapUrl < ActiveRecord::Migration[4.2]
  def up
    change_column :marriage_locations, :map_url, :text
  end

  def down
    change_column :marriage_locations, :map_url, :string
  end
end
