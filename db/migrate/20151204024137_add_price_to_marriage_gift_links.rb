class AddPriceToMarriageGiftLinks < ActiveRecord::Migration
  def change
    add_column :marriage_gift_links, :price, :float
  end
end
