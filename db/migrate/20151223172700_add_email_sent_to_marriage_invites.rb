class AddEmailSentToMarriageInvites < ActiveRecord::Migration
  def change
    add_column :marriage_invites, :welcome_sent, :boolean, default: false
  end
end
