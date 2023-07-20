# frozen_string_literal: true

module Admin
  module Marriage
    class GiftsController < ApplicationController
      include ::Admin::Common
      include ::Marriage::Gift::Common

      protect_from_forgery except: %i[create update]

      def create
        render json: created_gift_links
      end

      def update
        render json: updated_gift.as_json
      end

      private

      def updated_gift
        gift.update(update_params)
      end

      def update_params
        {}.tap do |attr|
          attr[:status] = :given if gift_params[:given]
        end
      end

      def gift_params
        @gift_params ||= params.require(:gift)
      end

      def created_gift_links
        ::Marriage::Gift::Creator.new(marriage, params).create
      end
    end
  end
end
