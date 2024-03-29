# frozen_string_literal: true

class AddBestManAndMaidToInvite < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_invites, :invite_honor, :boolean
    add_column :marriage_invites, :authentication_token, :string, limit: 16
    add_column :marriage_guests, :best_man, :boolean
    add_column :marriage_guests, :maid_honor, :boolean
  end
end
