# frozen_string_literal: true

class AddMarriageDisplayName < ActiveRecord::Migration[4.2]
  def change
    add_column :marriage_marriages, :display_name, :string
  end
end
