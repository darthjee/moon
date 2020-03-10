class AddCommentsToMarriageGifts < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gifts, :thread_id, :integer
  end
end
