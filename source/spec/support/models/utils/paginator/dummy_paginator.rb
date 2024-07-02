# frozen_string_literal: true

module Utils
  class Paginator
    class DummyPaginator < Utils::Paginator
      def key
        :documents
      end
    end
  end
end
