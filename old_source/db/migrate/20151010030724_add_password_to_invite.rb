# frozen_string_literal: true

class AddPasswordToInvite < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_invites, :password, :text
  end
end
