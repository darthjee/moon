# frozen_string_literal: true

class CreateBankAccount < ActiveRecord::Migration[4.2]
  def change
    create_table :bank_accounts do |t|
      t.integer :bank_id
      t.integer :marriage_id
      t.string :agency
      t.string :number
      t.timestamps
    end
  end
end
