module Marriage::Invite::Update
  extend ActiveSupport::Concern

  include Marriage::Invite::Common
  include Marriage::Services

  def update_invite_guests
    guests_update_params.each do |guest_params|
      guest = invite.guests.find(guest_params[:id])
      guest.update(guest_params)
    end
  end

  def update_user
    return if user.name.present?
    user.update(name: invite.guests.first.try(:name))
  end

  def create_invite_guests
    new_guests_params.each do |guest_params|
      attributes = guest_params.merge(invite: invite)
      Marriage::Guest.create(attributes)
    end
  end

  def remove_guests
    invite.guests.where(id: removed_guests_id).update_all(active: false)
  end

  def send_welcome_email
    return unless user.name.present?
    return if invite.welcome_sent

    mandrill_service.send_request(welcome_message)
    invite.update(welcome_sent: true)
  end

  private

  def user
    @user ||= User.for_invite(invite)
  end

  def welcome_message
    Mandrill::Request::Welcome.new(user, request.base_url)
  end

  def removed_guests_id
    params[:removed]
  end

  def guests_params
    invite_params[:guests]
  end

  def guests_update_params
    guests_params.select { |g| g[:id].present? }
  end

  def new_guests_params
    guests_params.select { |g| g[:id].blank? && g[:name].present? }
  end

  def check_valid_update
    invite.user.assign_attributes(user_update_params)
    if invite.valid?
      invite.save
    else
      render json: { errors: invite_errors }, status: :error
    end
  end

  def invite_params
    @invite_params ||= params.require(:invite).permit(:removed, guests: [:id, :name, :presence], user: :email)
  end

  def invite_errors
    invite.errors.messages.merge(
      user: invite.user.errors.messages
    )
  end

  def invite_update_params
    invite_params.permit(user: :email)
  end

  def user_update_params
    invite_params[:user]
  end
end
