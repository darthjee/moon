# frozen_string_literal: true

class AddAccontPersonInformationToBankAccounts < ActiveRecord::Migration[4.2]
  def change
    add_column :bank_accounts, :document, :string, limit: 14
    add_column :bank_accounts, :name, :string
  end
end
