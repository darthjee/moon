class Marriage::GuestsController < ApplicationController
  include Marriage::Common

  def index
  end

  def show
    render json: show_json
  end

  def search
    render json: guests_found
  end

  private

  def show_json
    {
      guest: guest_json,
      invite: guest_invite_json
    }
  end

  def guest_invite_json
    guest_invite.as_json(include: :guests)
  end

  def guest_invite
    guest.invite
  end

  def guest_json
    guest.as_json
  end

  def guest
    marriage.guests.find(guest_id)
  end

  def guest_id
    params.require(:id)
  end

  def guests_found
    marriage.guests.search_name(name).pluck_as_json(:id, :name)
  end

  def name
    params.require(:name)
  end
end
