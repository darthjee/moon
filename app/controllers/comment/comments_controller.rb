class Comment::CommentsController < ApplicationController
  include Marriage::Common

  skip_redirection_rule :render_root

  def index
    render json: thread.comments
  end

  private

  def thread
    marriage.threads.find(thread_id)
  end

  def thread_id
    params.require(:thread_id)
  end
end
