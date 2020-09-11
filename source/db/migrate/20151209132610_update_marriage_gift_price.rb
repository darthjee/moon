class UpdateMarriageGiftPrice < ActiveRecord::Migration[4.2]
  def up
    Marriage::Gift.unscoped.find_each do |gift|
      gift.update_prices
    end
  end
end
