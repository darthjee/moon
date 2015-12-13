class AddDisplayTypeToMarriageGifts < ActiveRecord::Migration
  def change
    add_column :marriage_gifts, :display_type, :string, default: :regular, null: false
  end
end
