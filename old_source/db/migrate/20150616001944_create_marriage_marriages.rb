# frozen_string_literal: true

class CreateMarriageMarriages < ActiveRecord::Migration[4.2]
  def change
    create_table :marriage_marriages do |t|
      t.date :date
      t.timestamps
    end
  end
end
