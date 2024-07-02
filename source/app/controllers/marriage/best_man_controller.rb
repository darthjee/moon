# frozen_string_literal: true

module Marriage
  class BestManController < ApplicationController
    include ::Marriage::Common

    protect_from_forgery except: :update
    skip_redirection :render_root, :list_honors

    def index
      render_basic
    end

    def show
      respond_to do |format|
        format.html { render :show }
      end
    end

    def update
      guest.update(update_params)
      render json: guest
    end

    def show_maids
      render json: guests
    end

    def list_honors
      render :list_honors, locals: {
        maids: marriage.guests.where(role: :maid_honor),
        best_men: marriage.guests.where(role: :best_man)
      }, layout: 'blank'
    end

    private

    def guests
      marriage.guests.where(role:)
    end

    def role
      params.require(:role)
    end

    def guest
      invite_from_credential.guests.find(id)
    end

    def id
      params.require(:id)
    end

    def update_params
      params.require(:guest).permit(:color)
    end

    def index_json
      user_from_credential.invite.as_json(include: :guests)
    end

    def invite
      user.find_by(code: invite_code).invite
    end

    def invite_code
      params[:code]
    end
  end
end
