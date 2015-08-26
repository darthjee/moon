class Marriage::InvitesController < ApplicationController
  include Marriage::Common

  protect_from_forgery except: :update

  def show
    respond_to do |format|
      format.json { render json: invite }
      format.html { render :show }
    end
  end

  def update
    guests_update_params.each do |guest_params|
      guest = invite.guests.find(guest_params[:id])
      guest.update(guest_params)
    end

    new_guests_params.each do |guest_params|
      attributes = guest_params.merge(invite: invite)
      Marriage::Guest.create(attributes)
    end

    invite.update(confirmed: invite.guests.confirmed.count)
    render json: {}
  end

  private

  def invite_params
    params.require(:invite).permit(guests: [:id, :name, :presence])
  end

  def guests_params
    invite_params.require(:guests)
  end

  def guests_update_params
    guests_params.select { |g| g[:id].present? }
  end

  def new_guests_params
    guests_params.select { |g| g[:id].blank? && g[:name].present? }
  end

  def invite
    @invite ||= invite_id ? invite_by_id : invite_by_code
  end

  def invite_by_id
    Marriage::Invite.find(invite_id)
  end

  def invite_by_code
    marriage.invites.find_by(code: invite_code)
  end

  def invite_id
    params[:id]
  end

  def invite_code
    params[:code]
  end
end
