class AddDressColorToGuest < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_guests, :color, :text, limit: 7
  end
end
