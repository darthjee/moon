class Marriage::LoginController < ApplicationController
  include Marriage::Login

  protect_from_forgery except: :create
  helper_method :redirection_path

  def index
  end

  def check
    if is_logged?
      render json: {}
    else
      render json: {}, status: :not_found
    end
  end

  def create
    sign_in if invite

    render json: {}
  end

  private

  def redirection_path
    params[:redirect_to]
  end

  def sign_in
    cookies.signed[:credentials] = invite.authentication_token
  end

  def invite
    marriage.invites.login(email, password)
  end

  def email
    login_params[:email]
  end

  def password
    login_params[:password]
  end

  def login_params
    params[:login]
  end
end
