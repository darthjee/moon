class AddUniqueHashCodeToMarriageInvite < ActiveRecord::Migration[4.2]
  def up
    add_column :marriage_invites, :code, :string, limit: 10
    add_index :marriage_invites, [:marriage_id, :code]

    Marriage::Invite.all.find_each do |invite|
      invite.start_code
    end
  end

  def down
    remove_column :marriage_invites, :code
  end
end
