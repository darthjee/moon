class Marriage::InvitesController < ApplicationController
  include Marriage::Invite::Update

  protect_from_forgery except: :update
  skip_redirection :render_root, :cards
  before_action :check_valid_update, only: :update

  def show
    respond_to do |format|
      format.json { show_json_invite }
      format.html { render :show }
      format.png { show_png_invite }
    end
  end

  def cards
    render :cards, locals: { invites: invites }, layout: 'blank'
  end

  def update
    update_invite_guests
    create_invite_guests
    invite.update(confirmed: invite.guests.confirmed.count)
    render json: invite.as_json(include: :guests)
  end

  private

  def show_json_invite
    invite.update(last_view_date: Time.zone.now)
    render json: invite.as_json(include: :guests)
  end

  def show_png_invite
    render text: show_path_qr_code
  end

  def show_path_qr_code
    QRCodeBuilder.new(show_path, 'public/icon.png').build
  end

  def show_path
    show_marriage_invites_url(invite.code, token: invite.authentication_token)
  end

  def invite_params
    @invite_params ||= params.require(:invite).permit(:email, guests: [:id, :name, :presence])
  end

  def invite_update_params
    invite_params.slice(:email)
  end

  def guests_params
    invite_params.require(:guests)
  end

  def invite
    @invite ||= find_invite
  end

  def invites
    @invites ||= marriage.invites.limit(per_page).offset(offset)
  end

  def offset
    (params[:page].to_i - 1) * per_page
  end

  def per_page
    @per_page ||= (params[:per_page] || 10).to_i
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
