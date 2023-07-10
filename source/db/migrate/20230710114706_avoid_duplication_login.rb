class AvoidDuplicationLogin < ActiveRecord::Migration[5.2]
  def up
    inner_query = <<-SQL
      SELECT login FROM users
      WHERE login IS NOT NULL
      GROUP BY login
      HAVING count(*) > 1
    SQL

    logins = execute(inner_query).to_a.flatten

    query = <<-SQL
      UPDATE users
      SET login=CONCAT(login, "_", id)
      WHERE login IN ("#{logins.join('","')}")
    SQL

    execute(query)
  end

  def down
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
end
