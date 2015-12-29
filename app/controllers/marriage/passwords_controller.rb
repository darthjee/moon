class Marriage::PasswordsController < ApplicationController
  include Marriage::Common
  include Marriage::Services

  protect_from_forgery except: :create

  def recovery
  end

  def create
    mandrill_service.send_request(password_request)
    render head: :ok, nothing: true
  end

  private

  def password_request
    Mandrill::Request::Password.new(user, request.base_url)
  end

  def user
    User.find_by!(email: email)
  end

  def email
    params.require(:email)
  end

end
