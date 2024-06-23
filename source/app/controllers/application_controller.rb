# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Azeroth::Resourceable

  helper Magicka::Helper

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def render_basic
    action = params[:action]
    respond_to do |format|
      format.json { render json: send("#{action}_json") }
      format.html { cached_render action }
    end
  end

  def forbidden
    head :forbidden
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
