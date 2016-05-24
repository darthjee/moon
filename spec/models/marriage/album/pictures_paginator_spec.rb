require 'spec_helper'

describe Marriage::Album::PicturesPaginator do
  it_behaves_like 'a paginator', described_class, :itens do
    let(:subject) { described_class.new(documents, pictures, params) }
    let(:marriage) { create(:marriage) }
    let(:album) { create(:album, marriage: marriage) }
    let(:documents) { subalbuns }
    let(:subalbuns) { marriage.albums }
    let(:pictures) { album.pictures }
    let(:documents_with_10_itens) do
      create(:marriage).tap do |marriage|
        10.times.each { create(:album, marriage: marriage) }
      end.albums
    end
    let(:documents_with_more_pages) do
      create(:marriage).tap do |marriage|
        (per_page * 2 + 2).times.each { create(:album, marriage: marriage) }
      end.albums
    end
    let(:first_documents) { documents.limit(per_page) }
    let(:last_documents) { documents.last(documents.count % per_page) }
  end
end
