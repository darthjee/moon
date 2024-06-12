# frozen_string_literal: true

class AddMissingAttributesToMarriageGifts < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gifts, :package, :integer, default: 1, null: false
    add_column :marriage_gifts, :bought, :integer, default: 0, null: false
    add_column :marriage_gifts, :status, :string, default: :open
  end

  def up
    Marriage::Gift.where.not(quantity: nil).uniq.pluck(:quantity).each do |quantity|
      Marriage::Gift.where(quantity: quantity).update_all(package: quantity)
    end
  end
end
