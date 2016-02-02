class Admin::LoginController < ApplicationController
  include Admin::Common

  skip_redirection :render_root, :forbidden

  def index
  end

  def forbidden
    head :forbidden
  end

  def check
    if is_admin?
      render json: {}
    else
      render json: {}, status: :not_found
    end
  end
end
