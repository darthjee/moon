# frozen_string_literal: true

class RemovePassword < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :password
  end

  def down
    change_table :users do |t|
      t.string :password, limit: 64
    end

    query = <<-SQL
      UPDATE users
      SET
        password=encrypted_password
      WHERE encrypted_password IS NOT NULL
    SQL

    execute(query)
  end
end
