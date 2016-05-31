module Marriage
  class AlbumsController < ApplicationController
    include Common

    def index
      render_basic
    end

    private

    def index_json
      Album::Paginator.new(albums, params).as_json
    end

    def albums
      marriage.albums.top_album
    end
  end
end
