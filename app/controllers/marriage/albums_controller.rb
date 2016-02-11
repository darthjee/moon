module Marriage
  class AlbumsController < ApplicationController
    include Common

    def index
      render json: index_json
    end

    private

    def index_json
      marriage.albums.as_json
    end
  end
end
