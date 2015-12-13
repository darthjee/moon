class AddStatusToMarriageGiftLink < ActiveRecord::Migration
  def change
    add_column :marriage_gift_links, :status, :string, default: :open
  end
end
