# frozen_string_literal: true

module Marriage
  class Picture < ApplicationRecord
    class Paginator < Utils::Paginator
      private

      def ordered_list
        paginated_list.order(:id)
      end

      def key
        :pictures
      end
    end
  end
end
