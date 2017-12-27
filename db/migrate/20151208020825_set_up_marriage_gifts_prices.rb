class SetUpMarriageGiftsPrices < ActiveRecord::Migration[4.2]
  def up
    remove_column :marriage_gifts, :price
    add_column :marriage_gifts, :min_price, :float, null: false, default: 0
    add_column :marriage_gifts, :max_price, :float, null: false, default: 0

    Marriage::Gift.all.find_each do |gift|
      gift.update(
        min_price: gift.min_link_price || 0,
        max_price: gift.max_link_price || 0
      )
    end
  end

  def down
    add_column :marriage_gifts, :price, :float
    remove_column :marriage_gifts, :min_price
    remove_column :marriage_gifts, :max_price
  end
end
