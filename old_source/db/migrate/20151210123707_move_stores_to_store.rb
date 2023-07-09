# frozen_string_literal: true

class MoveStoresToStore < ActiveRecord::Migration[4.2]
  def change
    rename_table :marriage_stores, :store_stores
    rename_table :marriage_store_lists, :store_lists
  end
end
