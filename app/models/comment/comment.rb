class Comment::Comment < ActiveRecord::Base
  belongs_to :thread
  belongs_to :user, class_name: 'User'

  default_scope do
    order(id: :desc)
  end

  def as_json(*args)
    super(*args).merge(
      user: user.as_json,
      time_ago: time_ago.as_json
    )
  end

  private

  def time_ago
    Utils::TimeElapsed.new(created_at)
  end
end
