class Marriage::InvitesController < ApplicationController
  include Marriage::Invite::Update
  include Marriage::Invite::Show
  include Marriage::Invite::List

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
    invite_updater.update
    send_welcome_email
    render json: invite.as_json(include: [:guests, :user])
  end
end
