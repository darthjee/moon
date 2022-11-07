# frozen_string_literal: true

class AddLocationToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_events, :location, :string
  end
end
