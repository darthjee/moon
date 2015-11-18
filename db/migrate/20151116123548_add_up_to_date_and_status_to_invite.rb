class AddUpToDateAndStatusToInvite < ActiveRecord::Migration
  def up
    add_column :marriage_invites, :status, :string
    add_column :marriage_invites, :up_to_date, :boolean

    Marriage::Invite.update_all(
      status: :created,
      up_to_date: true
    )
    ids = Marriage::Guest.all.distinct.pluck(:invite_id)
    Marriage::Invite.where(id: ids).update_all(
      status: :confirmed
    )
  end

  def down
    remove_column :marriage_invites, :status
    remove_column :marriage_invites, :up_to_date
  end
end
