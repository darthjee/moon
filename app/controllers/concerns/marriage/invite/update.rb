module Marriage::Invite::Update
  extend ActiveSupport::Concern

  include Marriage::Invite::Common
  include Marriage::Services

  private

  def check_valid_update
    if invite_updater.valid?
      invite_updater.save
    else
      render json: { errors: invite_updater.invite_errors }, status: :error
    end
  end

  def invite_updater
    @invite_updater ||= Marriage::Invite::Updater.new(invite, user, params)
  end

  def send_welcome_email
    return unless user.name.present?
    return if invite.welcome_sent

    mandrill_service.send_request(welcome_message)
    invite.update(welcome_sent: true)
  end

  def welcome_message
    Mandrill::Request::Welcome.new(user, request.base_url)
  end

  def user
    @user ||= User.for_invite(invite)
  end
end
