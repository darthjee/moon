class AddBgColorToMarriageStore < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_stores, :bg_color, :string, limit: 7, default: '#fff'
  end
end
