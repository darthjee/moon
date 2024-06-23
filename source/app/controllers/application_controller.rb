# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Azeroth::Resourceable

  helper Magicka::Helper

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
end
