class AddMarriageDisplayName < ActiveRecord::Migration
  def change
    add_column :marriage_marriages, :display_name, :string
  end
end
