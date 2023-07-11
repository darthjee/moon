# frozen_string_literal: true

module Marriage
  class Picture < ApplicationRecord
    module Common
      extend ActiveSupport::Concern
      include ::Marriage::Common

      def album
        @album ||= marriage.albums.find(params[:album_id])
      end
    end
  end
end
