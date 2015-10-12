class AddDressColorToGuest < ActiveRecord::Migration
  def change
    add_column :marriage_guests, :color, :text, limit: 7
  end
end
