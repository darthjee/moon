class PopulateNewUserFields < ActiveRecord::Migration[5.2]
  def up
    query = <<-SQL
      UPDATE users
      SET
        encrypted_password=password,
        salt=""
      WHERE password IS NOT NULL
    SQL

    execute(query)
  end

  def down
    query = <<-SQL
      UPDATE users
      SET
        encrypted_password=NULL,
        salt=NULL
    SQL

    execute(query)
  end
end
