# frozen_string_literal: true

module Marriage
  class GuestsController < ApplicationController
    include ::Marriage::Common

    def index; end

    def search
      render json: guests_found_json + invites_found_json
    end

    private

    def guests_found
      @guests_found ||= marriage.guests.search_name(name)
    end

    def guests_found_json
      guests_found.pluck_as_json(:id, :name)
    end

    def invites_found
      @invites_found ||= fetch_invites
    end

    def fetch_invites
      marriage.invites.search_label(name).where.not(id: guest_invites_ids)
    end

    def guest_invites_ids
      guests_found.uniq.pluck(:invite_id)
    end

    def invites_found_json
      invites_found.pluck_as_json(:code, :label)
    end

    def name
      params.require(:name)
    end
  end
end
