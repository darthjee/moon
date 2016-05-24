module Marriage
  class Album::PicturesPaginator

    attr_reader :albums, :pictures, :params

    def initialize(albums, pictures, params)
      @albums = albums
      @pictures = pictures
      @params = params
    end

    def as_json
      album_paginator.empty? ? pictures_json : albums_json
    end

    private

    def pictures_json
      picture_paginator.as_json.remap_keys pictures: :itens
    end

    def picture_paginator
      @picture_paginator ||= Picture::Paginator.new(pictures, params)
    end

    def albums_json
      album_paginator.as_json.remap_keys albums: :itens
    end

    def album_paginator
      @album_paginator ||= Album::Paginator.new(albums, params)
   end
  end
end
