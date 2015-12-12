module Marriage
    class GiftsController < ApplicationController
    include Common

    before_action :require_admin, only: :create
    protect_from_forgery except: :create

    def index
      respond_to do |format|
        format.json { render json: gifts_list_json }
        format.html { cached_render :index }
      end
    end

    def create
      render json: created_gift_links
    end

    private

    def created_gift_links
      Gift::Creator.new(marriage, params).create
    end
  end
end
