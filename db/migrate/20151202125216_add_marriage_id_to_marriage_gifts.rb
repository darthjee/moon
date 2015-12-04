class AddMarriageIdToMarriageGifts < ActiveRecord::Migration
  def change
    add_column :marriage_gifts, :marriage_id, :integer
  end
end
