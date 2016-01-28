module Admin::Marriage
  class GiftsController < ApplicationController
    include Marriage::Common

    before_action :require_admin, only: :create
    protect_from_forgery except: :create

    def create
      render json: created_gift_links
    end

    private

    def created_gift_links
      Marriage::Gift::Creator.new(marriage, params).create
    end
  end
end
