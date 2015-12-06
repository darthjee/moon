class AddPriceToMarriageGifts < ActiveRecord::Migration
  def change
    add_column :marriage_gifts, :price, :float
  end
end
