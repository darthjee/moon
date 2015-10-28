class CreateMandrillEmailSettings < ActiveRecord::Migration
  def change
    create_table :mandrill_email_settings do |t|
      t.string :mandrill_email_settings
      t.string :key
      t.string :template_name
    end
  end
end
