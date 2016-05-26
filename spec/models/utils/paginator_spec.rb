require 'spec_helper'

describe Utils::Paginator do
  class Utils::Paginator::DummyPaginator < Utils::Paginator
    def key
      :documents
    end
  end

  it_behaves_like 'a paginator extending utils paginator', described_class::DummyPaginator, :documents do
    let(:album) { marriage_albums(:first) }
    let(:documents) { album.pictures }
    let(:documents_with_10_itens) do
      create(:album).tap do |album|
        10.times.each { create(:picture, album: album) }
      end.pictures
    end
    let(:documents_with_more_pages) do
      create(:album).tap do |album|
        (per_page * 2 + 2).times.each { create(:picture, album: album) }
      end.pictures
    end
    let(:first_documents) { documents.limit(per_page) }
    let(:last_documents) { documents.last(documents.count % per_page) }
  end
end
