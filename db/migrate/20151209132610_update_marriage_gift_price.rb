class UpdateMarriageGiftPrice < ActiveRecord::Migration
  def up
    Marriage::Gift.all.find_each do |gift|
      gift.update_prices
    end
  end
end
