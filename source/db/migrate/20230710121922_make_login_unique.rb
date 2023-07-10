class MakeLoginUnique < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.index :login, unique: :true
      t.index :email, unique: :true
    end
  end
end
