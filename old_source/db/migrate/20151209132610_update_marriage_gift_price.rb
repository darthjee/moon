# frozen_string_literal: true

class UpdateMarriageGiftPrice < ActiveRecord::Migration[4.2]
  def up
    Marriage::Gift.unscoped.find_each(&:update_prices)
  end
end
