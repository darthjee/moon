class CreateCommentThread < ActiveRecord::Migration
  def change
    create_table :comment_threads do |t|
      t.integer :marriage_id
      t.string :name
      t.string :status,     limit: 14, default: 'active'
      t.timestamps
    end
  end
end
