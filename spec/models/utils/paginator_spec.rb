require 'spec_helper'

describe Utils::Paginator do
  class Utils::Paginator::DummyPaginator < Utils::Paginator
    def key
      :documents
    end
  end

  it_behaves_like 'a paginator', described_class::DummyPaginator do
    let(:album) { marriage_albums(:first) }
    let(:documents) { album.pictures }
    let(:album10) { create(:album) }
    let(:album_with_more_pages) do
      create(:album).tap do |album|
        (per_page * 2 + 2).times.each { create(:picture, album: album) }
      end
    end
    let(:first_documents) { documents.limit(per_page) }
    let(:last_documents) { documents.last(2) }

    before do
      10.times.each { create(:picture, album: album10) }
    end
  end
end
