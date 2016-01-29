class Admin::LoginController < ApplicationController
  include Admin::Common

  skip_redirection :render_root, :forbidden

  def index
  end

  def forbidden
    head :forbidden
  end
end
