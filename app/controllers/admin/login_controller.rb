class Admin::LoginController < ApplicationController
  include Admin::Common

  def index
  end

  def forbidden
    head :forbidden
  end
end
