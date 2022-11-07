# frozen_string_literal: true

class CorrectMandrillEmailSettings < ActiveRecord::Migration[4.2]
  def change
    remove_column :mandrill_email_settings, :mandrill_email_settings

    change_table :mandrill_email_settings, &:timestamps
  end
end
