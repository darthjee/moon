class Marriage::Invite::Updater
  include Marriage::Services

  attr_reader :invite, :request, :params

  delegate :valid?, :save, to: :invite

  def initialize(invite, request, params)
    @invite = invite
    @request = request
    @params = params

    invite.user.assign_attributes(user_update_params)
  end

  def update
    update_invite_guests
    create_invite_guests
    update_user
    remove_guests
    invite.update(confirmed: invite.guests.confirmed.count)
    send_welcome_email
  end

  private


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

  def guests_update_params
    guests_params.select { |g| g[:id].present? }
  end

  def guests_params
    invite_params[:guests]
  end

  def user_update_params
    invite_params[:user]
  end

  def new_guests_params
    guests_params.select { |g| g[:id].blank? && g[:name].present? }
  end

  def user
    @user ||= User.for_invite(invite)
  end

  def invite_params
    @invite_params ||= params.require(:invite).permit(:removed, guests: [:id, :name, :presence], user: :email)
  end

  def removed_guests_id
    params[:removed]
  end

  def welcome_message
    Mandrill::Request::Welcome.new(user, request.base_url)
  end
end
