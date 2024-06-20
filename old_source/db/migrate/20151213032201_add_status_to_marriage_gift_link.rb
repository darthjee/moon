# frozen_string_literal: true

class AddStatusToMarriageGiftLink < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gift_links, :status, :string, default: :open
  end
end
