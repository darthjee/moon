class MakeInviteStatusDefault < ActiveRecord::Migration[4.2]
  def up
    change_column :marriage_invites, :status, :string, default: :created, limit: 10
  end

  def down
    change_column :marriage_invites, :status, :string, default: nil
  end
end
