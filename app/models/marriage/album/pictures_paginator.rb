module Marriage
  class Album::PicturesPaginator

    attr_reader :albums, :pictures, :params

    def initialize(albums, pictures, params)
      @albums = albums
      @pictures = pictures
      @params = params
    end

    def as_json
      album_paginator.as_json.remap_keys albums: :itens
    end

    private

    def album_paginator
      @album_paginator ||= Album::Paginator.new(albums, params)
   end
  end
end
