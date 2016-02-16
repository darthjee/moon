class Comment::Comment::Creator
  attr_reader :thread, :params

  delegate :valid?, to: :user

  def initialize(thread, params)
    @thread = thread
    @params = params
  end

  def user
    @user ||= update_or_create_user
  end

  def created_comment
    @created_comment ||= create
  end

  def create
    @created_comment = thread.comments.create(comment_creation_params)
  end

  private

  def update_or_create_user
    fetch_user.tap do |u|
      u.update(user_params)
    end
  end

  def fetch_user
    User.find_or_create_by(user_params.slice(:email))
  end

  def user_params
    comment_params.require(:user).permit(:name, :email)
  end

  def comment_creation_params
    comment_params.permit(:text).merge(user: user)
  end

  def comment_params
    params.require(:comment)
  end
end

