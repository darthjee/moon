module Marriage
    class GiftsController < ApplicationController
    include Common

    before_action :require_admin, only: :create
    protect_from_forgery except: :create

    def index
      render_basic
    end

    def show
      render_basic
    end

    def create
      render json: created_gift_links
    end

    private

    def created_gift_links
      Gift::Creator.new(marriage, params).create
    end

    def index_json
      Gift::Paginator.new(marriage.gifts, params).as_json
    end

    def show_json
      marriage.gifts.find(params[:id].as_json)
    end
  end
end
