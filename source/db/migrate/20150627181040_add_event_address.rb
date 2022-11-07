# frozen_string_literal: true

class AddEventAddress < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_events, :address, :string
  end
end
