class AddEmailToInvite < ActiveRecord::Migration
  def change
    add_column :marriage_invites, :email, :string
  end
end
