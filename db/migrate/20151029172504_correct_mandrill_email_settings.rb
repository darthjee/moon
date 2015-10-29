class CorrectMandrillEmailSettings < ActiveRecord::Migration
  def change
    remove_column :mandrill_email_settings, :mandrill_email_settings

    change_table :mandrill_email_settings do |t|
      t.timestamps
    end
  end
end
