# frozen_string_literal: true

module Marriage
  class LoginController < ApplicationController
    include ::Marriage::Common

    protect_from_forgery except: :create

    def index; end

    def check
      if logged?
        render json: {}
      else
        render json: {}, status: :not_found
      end
    end

    def create
      if user_from_login
        sign_in

        render json: {}
      else
        render json: {}, status: :not_found
      end
    end

    def show
      render json: user_from_credential_json
    end

    private

    def user_from_credential_json
      user_from_credential.as_json
    end

    def sign_in
      cookies.signed[:credentials] = user_from_login.authentication_token
    end

    def user_from_login
      @user_from_login = User.login(email, password)
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
end
