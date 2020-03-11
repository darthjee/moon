module Marriage
  class AlbumsController < ApplicationController
    include Common

    def index
      render_basic
    end

    private

    def index_json
      Album::Paginator.new(marriage.albums, params).as_json
    end
  end
end
