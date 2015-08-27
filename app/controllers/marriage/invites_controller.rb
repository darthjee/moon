class Marriage::InvitesController < ApplicationController
  include Marriage::Common

  protect_from_forgery except: :update

  def show
    respond_to do |format|
      format.json { render json: invite.as_json(include: :guests) }
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
    @invite ||= find_invite
  end

  def find_invite
    return invite_by_id if invite_id
    invite_code ? invite_by_code : guest_invite
  end

  def guest_invite
    guest.invite
  end

  def invite_by_id
    Marriage::Invite.find(invite_id)
  end

  def invite_by_code
    marriage.invites.find_by(code: invite_code)
  end

  def guest
    marriage.guests.find(guest_id)
  end

  def guest_id
    params[:guest_id]
  end

  def invite_id
    params[:id]
  end

  def invite_code
    params[:code]
  end
end
