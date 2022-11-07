# frozen_string_literal: true

module Marriage
  module Picture::Common
    extend ActiveSupport::Concern
    include ::Marriage::Common

    def album
      @album ||= marriage.albums.find(params[:album_id])
    end
  end
end
