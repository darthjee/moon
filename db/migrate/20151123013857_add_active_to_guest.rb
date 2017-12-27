class AddActiveToGuest < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_guests, :active, :boolean, default: true, null: false
  end
end
