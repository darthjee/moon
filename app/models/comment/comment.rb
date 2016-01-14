class Comment::Comment < ActiveRecord::Base
  belongs_to :thread
  belongs_to :user, class_name: 'User'

  default_scope do
    order(id: :desc)
  end

  def as_json(*args)
    super(*args).merge(
      user: user.as_json
    )
  end
end
