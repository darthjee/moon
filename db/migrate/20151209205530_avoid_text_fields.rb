class AvoidTextFields < ActiveRecord::Migration
  def up
    change_column :marriage_guests, :color, :string, limit: 7
    change_column :marriage_guests, :role, :string, limit: 20
    change_column :marriage_invites, :password, :string, limit: 64
  end

  def down
    change_column :marriage_guests, :color, :text
    change_column :marriage_guests, :role, :text
    change_column :marriage_invites, :password, :text
  end
end
