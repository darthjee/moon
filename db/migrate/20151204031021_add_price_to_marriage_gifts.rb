class AddPriceToMarriageGifts < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gifts, :price, :float
  end
end
