# frozen_string_literal: true

class AddViewDateToInvite < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_invites, :last_view_date, :time
  end
end
