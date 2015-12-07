class AddQuantityToMarriageGifts < ActiveRecord::Migration
  def change
    add_column :marriage_gifts, :quantity, :integer, null: false, default: 1
  end
end
