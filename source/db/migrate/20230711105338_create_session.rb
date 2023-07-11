class CreateSession < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false, size: 11
      t.datetime :expiration
      t.string :token, limit: 64, null: false

      t.index :token, unique: true
    end

    add_foreign_key :sessions, :users
  end
end
