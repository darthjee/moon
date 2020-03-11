class AddPriceToMarriageGiftLinks < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gift_links, :price, :float
  end
end
