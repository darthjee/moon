module Marriage
  module Picture::Common
    extend ActiveSupport::Concern
    include Common

    def album
      @album ||= marriage.albums.find(params[:album_id])
    end
  end
end
