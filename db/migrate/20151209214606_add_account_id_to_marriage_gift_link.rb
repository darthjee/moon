class AddAccountIdToMarriageGiftLink < ActiveRecord::Migration
  def change
    add_column :marriage_gift_links, :account_id, :integer
  end
end
