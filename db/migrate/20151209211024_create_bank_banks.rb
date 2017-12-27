class CreateBankBanks < ActiveRecord::Migration[4.2]
  def change
    create_table :bank_banks do |t|
      t.string :name
      t.string :image_url
      t.timestamps
    end
  end
end
