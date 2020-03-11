class AddAccountIdToMarriageGiftLink < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gift_links, :account_id, :integer
  end
end
