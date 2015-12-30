class Marriage::PasswordsController < ApplicationController
  include Marriage::Common
  include Marriage::Services

  protect_from_forgery except: [:create, :update]

  def recovery
  end

  def create
    mandrill_service.send_request(password_request)
    render head: :ok, nothing: true
  end

  def edit
  end

  def update
    user_from_credential.update(params[:password])
    render json: {}
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
