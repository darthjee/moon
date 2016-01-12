class Marriage::BestManController < ApplicationController
  include Marriage::Common

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

  def show_maids
    render json: maids
  end

  private

  def maids
    marriage.guests.where(role: role)
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

  def invite_from_credential_json
    user_from_credential.invite.as_json(include: :guests)
  end

  def invite
    user.find_by(code: invite_code).invite
  end

  def invite_code
    params[:code]
  end
end
