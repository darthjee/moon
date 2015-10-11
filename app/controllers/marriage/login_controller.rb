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
    if invite_from_login
      sign_in

      render json: {}
    else
      render json: {}, status: :not_found
    end
  end

  private

  def redirection_path
    params[:redirect_to]
  end

  def sign_in
    cookies.signed[:credentials] = invite_from_login.authentication_token
  end

  def invite_from_login
    @invite_from_login = marriage.invites.login(email, password)
  end

  def email
    login_params[:email]
  end

  def password
    login_params[:password]
  end

  def login_params
    params.require(:login)
  end
end
