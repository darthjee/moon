class AddCommentsToMarriageGifts < ActiveRecord::Migration
  def change
    add_column :marriage_gifts, :thread_id, :integer
  end
end
