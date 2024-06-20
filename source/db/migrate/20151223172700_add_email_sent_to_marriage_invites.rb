# frozen_string_literal: true

class AddEmailSentToMarriageInvites < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_invites, :welcome_sent, :boolean, default: false
  end
end
