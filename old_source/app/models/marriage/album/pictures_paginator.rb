# frozen_string_literal: true

module Marriage
  class Album < ActiveRecord::Base
    class PicturesPaginator
      attr_reader :albums, :pictures, :params

      def initialize(albums, pictures, params)
        @albums = albums
        @pictures = pictures
        @params = params
      end

      def as_json
        pictures_json.tap do |json|
          json[:itens] = albums_json[:itens] + json[:itens]
          json[:pages] = [albums_json[:pages], json[:pages]].max
        end
      end

      private

      def pictures_json
        @pictures_json ||= picture_paginator.as_json.remap_keys pictures: :itens
      end

      def picture_paginator
        @picture_paginator ||= Picture::Paginator.new(
          pictures, picture_paginator_params
        )
      end

      def picture_paginator_params
        params.merge(offset: -album_paginator.next_page_offset)
      end

      def albums_json
        @albums_json ||= album_paginator.as_json.remap_keys albums: :itens
      end

      def album_paginator
        @album_paginator ||= Album::Paginator.new(albums, params)
      end
    end
  end
end
