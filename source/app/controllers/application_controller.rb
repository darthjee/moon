# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Azeroth::Resourceable

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def render_basic
    action = params[:action]
    respond_to do |format|
      format.json { render json: send("#{action}_json") }
      format.html { cached_render action }
    end
  end

  def not_found
    head :not_found
  end

  def cached_render(view)
    Rails.cache.fetch "render:#{params[:controller]}:#{view}" do
      render view
    end
  end
end
