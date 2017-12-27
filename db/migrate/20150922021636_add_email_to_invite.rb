class AddEmailToInvite < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_invites, :email, :string
  end
end
