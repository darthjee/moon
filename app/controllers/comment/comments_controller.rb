class Comment::CommentsController < ApplicationController
  include Marriage::Common

  skip_redirection_rule :render_root
  protect_from_forgery except: :create

  def index
    render json: thread.comments
  end

  def create
    user
    render json: {}
  end

  private

  def user
    find_user.tap do |u|
      u.update(user_params)
    end
  end

  def find_user
    @find_user ||= User.find_or_create_by(user_params.slice(:email))
  end

  def user_params
    comment_params.require(:user).permit(:name, :email)
  end

  def comment_params
    params.require(:comment)
  end

  def thread
    marriage.threads.find(thread_id)
  end

  def thread_id
    params.require(:thread_id)
  end
end
