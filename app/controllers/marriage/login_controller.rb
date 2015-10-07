class Marriage::LoginController < ApplicationController
  include Marriage::Login

  protect_from_forgery except: :create

  def index
  end

  def create
    sign_in if invite

    render json: {}
  end

  private

  def sign_in
    cookies.signed[:credentials] = invite.authentication_token
  end

  def invite
    marriage.invites.find_by(email: email)
  end

  def email
    login_params[:email]
  end

  def login_params
    params[:login]
  end
end
