module Marriage
  class PicturesController < ApplicationController
    include Picture::Common

    def index
      render_basic
    end

    private

    def index_json
      Picture::Paginator.new(album.pictures, params).as_json
    end
  end
end
