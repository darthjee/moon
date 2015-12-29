class Marriage::PasswordsController < ApplicationController
  include Marriage::Common

  protect_from_forgery except: :create

  def recovery
  end

  def create
    user
    render head: :ok, nothing: true
  end

  def user
    User.find_by!(email: email)
  end

  def email
    params.require(:email)
  end

end
