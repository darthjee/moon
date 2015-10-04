class AddViewDateToInvite < ActiveRecord::Migration
  def change
    add_column :marriage_invites, :last_view_date, :time
  end
end
