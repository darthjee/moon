class AddLocationToEvent < ActiveRecord::Migration
  def change
    add_column :marriage_events, :location, :string
  end
end
