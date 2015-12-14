class AddAccontPersonInformationToBankAccounts < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :document, :string, limit: 14
    add_column :bank_accounts, :name, :string
  end
end
