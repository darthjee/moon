module Admin::Marriage
  class PicturesController < ApplicationController
    include Admin::Common
    include ::Marriage::Picture::Common

    def update
      picture.update()
    end

    private

    def update_params
      params.permit(:name, :album_id)
    end

    def picture
      @picture ||= album.pictures.find(picture_id)
    end

    def picture_id
      params.require(:id)
    end
  end
end
