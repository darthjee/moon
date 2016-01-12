class AddTypeToBankAccounts < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :account_type, :string, default: 'savings', limit: 10
  end
end
