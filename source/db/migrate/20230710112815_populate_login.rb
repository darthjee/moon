class PopulateLogin < ActiveRecord::Migration[5.2]
  def up
    query = <<-SQL
      SELECT id, email FROM users
      WHERE
        password IS NOT NULL
        AND email IS NOT NULL
    SQL

    execute(query).each do |id, email|
      login = email.gsub(/@.*/,'')

      update_query = <<-SQL
        UPDATE users
        SET login="#{login}"
        WHERE id=#{id}
      SQL
      execute(update_query)
    end
  end

  def down
    query = <<-SQL
      UPDATE users
      SET
        login=NULL
    SQL

    execute(query)
  end
end
