class AddPasswordToInvite < ActiveRecord::Migration
  def change
    add_column :marriage_invites, :password, :text
  end
end
