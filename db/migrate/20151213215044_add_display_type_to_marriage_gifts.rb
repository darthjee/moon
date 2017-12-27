class AddDisplayTypeToMarriageGifts < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_gifts, :display_type, :string, default: :regular, null: false
  end
end
