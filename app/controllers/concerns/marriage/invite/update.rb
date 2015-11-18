module Marriage::Invite::Update
  extend ActiveSupport::Concern

  include Marriage::Invite::Common

  def update_invite_guests
    guests_update_params.each do |guest_params|
      guest = invite.guests.find(guest_params[:id])
      guest.update(guest_params)
    end
  end

  def create_invite_guests
    new_guests_params.each do |guest_params|
      attributes = guest_params.merge(invite: invite)
      Marriage::Guest.create(attributes)
    end
  end

  private

  def guests_params
    invite_params.require(:guests)
  end

  def guests_update_params
    guests_params.select { |g| g[:id].present? }
  end

  def new_guests_params
    guests_params.select { |g| g[:id].blank? && g[:name].present? }
  end

  def check_valid_update
    invite.assign_attributes(invite_update_params)
    unless invite.valid?
      render json: { errors: invite.errors.messages }, status: :error
    end
  end

  def invite_params
    @invite_params ||= params.require(:invite).permit(:email, guests: [:id, :name, :presence])
  end

  def invite_update_params
    invite_params.slice(:email)
  end
end
