# frozen_string_literal: true

class CreateCommentComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comment_comments do |t|
      t.text :text
      t.integer :thread_id
      t.integer :user_id
      t.timestamps
    end
  end
end
