module Marriage
  class GiftsController < ApplicationController
    include Common

    def index
      render_basic
    end

    def show
      render_basic
    end

    private

    def index_json
      Gift::Paginator.new(marriage.gifts, params).as_json
    end

    def show_json
      marriage.gifts.find(params[:id].as_json)
    end
  end
end
