class AddTypeToBankAccounts < ActiveRecord::Migration[4.2]
  def change
    add_column :bank_accounts, :account_type, :string, default: 'savings', limit: 10
  end
end
