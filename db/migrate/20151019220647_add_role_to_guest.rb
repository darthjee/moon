class AddRoleToGuest < ActiveRecord::Migration
  def up
    add_column :marriage_guests, :role, :text
    %w(best_man maid_honor).each do |role|
      Marriage::Guest.where(role => true).each do |guest|
        guest.update(role: role)
      end
      remove_column :marriage_guests, role
    end
  end

  def down
    %w(best_man maid_honor).each do |role|
      add_column :marriage_guests, role, :boolean
    end
    Marriage::Guest.where.not(role: nil).each do |guest|
      guest.update(guest.role => 't')
    end
    remove_column :marriage_guests, :role
  end
end