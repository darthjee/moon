# frozen_string_literal: true

module Marriage
  class Album < ApplicationRecord
    class Paginator < Utils::Paginator
      private

      def ordered_list
        paginated_list.order(:id)
      end

      def key
        :albums
      end
    end
  end
end
