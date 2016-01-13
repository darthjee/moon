class Comment::Comment < ActiveRecord::Base
  belongs_to :thread
  belongs_to :user, class_name: 'User'

  default_scope do
    order(id: :desc)
  end
end
