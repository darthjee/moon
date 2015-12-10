class MoveStoresToStore < ActiveRecord::Migration
  def change
    rename_table :marriage_stores, :store_stores
    rename_table :marriage_store_lists, :store_lists
  end
end
