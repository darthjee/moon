# frozen_string_literal: true

class AddEncryptedPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :login
      t.string :encrypted_password, limit: 64
      t.string :salt, limit: 64
    end
  end
end
