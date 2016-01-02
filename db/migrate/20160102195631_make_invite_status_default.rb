class MakeInviteStatusDefault < ActiveRecord::Migration
  def up
    change_column :marriage_invites, :status, :string, default: :created, limit: 10
  end

  def down
    change_column :marriage_invites, :status, :string, default: nil
  end
end
