# frozen_string_literal: true

module Admin::Marriage
  class PicturesController < ApplicationController
    include Admin::Common
    include ::Marriage::Picture::Common

    protect_from_forgery except: :create

    def update
      picture.update(update_params)

      render json: picture
    end

    private

    def update_params
      params.require(:picture).permit(:name, :album_id, :status)
    end

    def picture
      @picture ||= album.pictures.find(picture_id)
    end

    def picture_id
      params.require(:id)
    end
  end
end
