class CreateCommentComments < ActiveRecord::Migration
  def change
    create_table :comment_comments do |t|
      t.text :text
      t.integer :thread_id
      t.integer :user_id
      t.timestamps
    end
  end
end
