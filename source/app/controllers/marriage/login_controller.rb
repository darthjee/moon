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
      @user_from_login = User.login(login: login, password: password)
    end

    def login
      params[:login]
    end

    def password
      params[:password]
    end
  end
end
