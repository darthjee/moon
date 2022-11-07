# frozen_string_literal: true

class Comment::CommentsController < ApplicationController
  include Marriage::Common

  skip_redirection_rule :render_root
  protect_from_forgery except: :create
  before_action :check_valid_create, only: :create

  def index
    render json: thread.comments
  end

  def create
    render json: created_comment
  end

  private

  def check_valid_create
    if creator.valid?
      creator.save
    else
      render json: creation_errors, status: :unprocessable_entity
    end
  end

  def creation_errors
    { errors: creator.errors }
  end

  def creator
    @creator ||= Comment::Comment::Creator.new(thread, params)
  end

  def created_comment
    creator.comment
  end

  def thread
    marriage.threads.find(thread_id)
  end

  def thread_id
    params.require(:thread_id)
  end
end
