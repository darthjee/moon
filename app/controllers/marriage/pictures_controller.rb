module Marriage
  class PicturesController < ApplicationController
    include Common

    def index
      render_basic
    end

    private

    def index_json
      Picture::Paginator.new(album.pictures, params).as_json
    end

    def album
      marriage.albums.find(params[:album_id])
    end
  end
end
