# frozen_string_literal: true

class ChangeMarriageInviteCodeSize < ActiveRecord::Migration[4.2]
  def up
    execute 'UPDATE marriage_invites SET code = NULL'

    change_column :marriage_invites, :code, :string, limit: 4

    Marriage::Invite.unscoped.all.find_each do |invite|
      invite.start_code(2)
    end
  end

  def down
    change_column :marriage_invites, :code, :string, limit: 10

    Marriage::Invite.unscoped.all.find_each do |invite|
      invite.code = nil
      invite.start_code(5)
    end
  end
end
