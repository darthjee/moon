# frozen_string_literal: true

class AddPriceToMarriageGifts < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gifts, :price, :float
  end
end
