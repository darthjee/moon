class AddPasswordToUser < ActiveRecord::Migration
  def up
    add_column :users, :password, :string, limit: 64

    Marriage::Invite.all.each do |invite|
      invite.user.update_column(:password, invite.password)
    end
  end

  def down
    remove_column :users, :password
  end
end
