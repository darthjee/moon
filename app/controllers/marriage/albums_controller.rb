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
      album_id ? sub_albums : top_album
    end

    def sub_albums
      album.albums
    end

    def top_album
      marriage.albums.top_album
    end

    def album
      @album ||= Album.find(album_id)
    end

    def album_id
      params[:album_id]
    end
  end
end
