module Marriage::Invite::Update
  extend ActiveSupport::Concern

  include Marriage::Invite::Common
  include Marriage::Services

  def check_valid_update
    if invite_updater.valid?
      invite_updater.save
    else
      render json: { errors: invite_updater.invite_errors }, status: :error
    end
  end

  def invite_updater
    @invite_updater ||= Marriage::Invite::Updater.new(invite, params)
  end
end
