# frozen_string_literal: true

class AddUniqueHashCodeToMarriageInvite < ActiveRecord::Migration[4.2]
  def up
    add_column :marriage_invites, :code, :string, limit: 10
    add_index :marriage_invites, %i[marriage_id code]

    Marriage::Invite.unscoped.all.find_each(&:start_code)
  end

  def down
    remove_column :marriage_invites, :code
  end
end
