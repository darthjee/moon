class AddEventAddress < ActiveRecord::Migration
  def change
    add_column :marriage_events, :address, :string
  end
end
