class AddStoreLikeAttributesToBankBanks < ActiveRecord::Migration
  def change
    add_column :bank_banks, :bg_color, :string, limit: 7, default: '#fff'
  end
end
