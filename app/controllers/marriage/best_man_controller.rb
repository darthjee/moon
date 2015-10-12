class Marriage::BestManController < ApplicationController
  include Marriage::Login

  protect_from_forgery except: :update

  def index
    respond_to do |format|
      format.json { render json: invite_from_credential_json }
      format.html { render :index }
    end
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

  private

  def guest
    invite_from_credential.guests.find(id)
  end

  def id
    params.require(:id)
  end

  def update_params
    params.require(:guest).permit(:color)
  end

  def invite_from_credential_json
    invite_from_credential.as_json(include: :guests)
  end

  def invite
    marriage.invites.find_by(code: invite_code)
  end

  def invite_code
    params[:code]
  end
end
