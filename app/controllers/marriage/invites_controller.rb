class Marriage::InvitesController < ApplicationController
  include Marriage::Common

  def index
  end

  def search
    render json: guests_found
  end

  private

  def guests_found
    marriage.guests.where('name LIKE ?', "%#{name}%").pluck(:id, :name).map{ |i| i.as_hash([:id, :name]) }
  end

  def name
    params.require(:name)
  end
end
