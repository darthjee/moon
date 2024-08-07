# frozen_string_literal: true

module Marriage
  class PasswordsController < ApplicationController
    include ::Marriage::Common
    include ::Marriage::Services

    protect_from_forgery except: %i[create update]

    def recovery; end

    def create
      mandrill_service.recover_password(user, request.base_url)
      render head: :ok, body: nil
    end

    def edit; end

    def update
      user_from_credential.update(password: new_password)
      render json: {}
    end

    private

    def new_password
      params.require(:password)
    end

    def user
      User.find_by!(email:)
    end

    def email
      params.require(:email)
    end
  end
end
