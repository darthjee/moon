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

    before do
      10.times.each { create(:picture, album: album10) }
    end
  end
end
