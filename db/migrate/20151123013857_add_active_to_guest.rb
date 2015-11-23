class AddActiveToGuest < ActiveRecord::Migration
  def change
    add_column :marriage_guests, :active, :boolean, default: true, null: false
  end
end
