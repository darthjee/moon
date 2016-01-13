class Marriage::Gift::Updater
  def initialize

  end

  def update
    update_invite_guests
    create_invite_guests
    update_user
    remove_guests
    invite.update(confirmed: invite.guests.confirmed.count)
    send_welcome_email
    render json: invite.as_json(include: [:guests, :user])
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
end