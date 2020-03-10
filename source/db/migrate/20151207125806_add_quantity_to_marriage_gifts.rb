class AddQuantityToMarriageGifts < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gifts, :quantity, :integer, null: false, default: 1
  end
end
