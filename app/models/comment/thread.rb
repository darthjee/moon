class Comment::Thread < ActiveRecord::Base
  has_many :comments
end
