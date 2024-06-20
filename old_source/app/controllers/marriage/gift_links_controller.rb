# frozen_string_literal: true

module Marriage
  class GiftLinksController < ApplicationController
    include ::Marriage::Common

    def show
      render_basic
    end

    private

    def show_json
      gift_link.as_json(include: :gift)
    end

    def gift_link
      Marriage::GiftLink.find(link_id).as_json(include: :gift)
    end

    def link_id
      params.require(:id)
    end
  end
end
