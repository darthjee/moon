class AddMarriageIdToMarriageGifts < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gifts, :marriage_id, :integer
  end
end
