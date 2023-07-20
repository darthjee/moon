# frozen_string_literal: true

module Marriage
  class Gift < ApplicationRecord
    module Common
      extend ActiveSupport::Concern

      include ::Marriage::Common

      def gift
        marriage.gifts.find(params[:id])
      end
    end
  end
end
