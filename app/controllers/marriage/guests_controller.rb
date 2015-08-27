class Marriage::GuestsController < ApplicationController
  include Marriage::Common

  def index
  end

  def search
    render json: guests_found
  end

  private

  def guests_found
    marriage.guests.search_name(name).pluck_as_json(:id, :name)
  end

  def name
    params.require(:name)
  end
end
