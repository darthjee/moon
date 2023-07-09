# frozen_string_literal: true

module Admin
  class LoginController < ApplicationController
    include Admin::Common

    skip_redirection :render_root, :forbidden

    def index
      render_basic
    end

    def forbidden
      head :forbidden
    end

    def check
      if admin?
        render json: {}
      else
        render json: {}, status: :not_found
      end
    end

    private

    def index_json
      { status: :ok }
    end
  end
end
