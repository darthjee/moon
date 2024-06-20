# frozen_string_literal: true

class AddStoreLikeAttributesToBankBanks < ActiveRecord::Migration[4.2]
  def change
    add_column :bank_banks, :bg_color, :string, limit: 7, default: '#fff'
  end
end
