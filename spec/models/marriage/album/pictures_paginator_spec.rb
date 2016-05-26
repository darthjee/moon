require 'spec_helper'

describe Marriage::Album::PicturesPaginator do
  let(:marriage) { create(:marriage) }
  let(:album) { create(:album, marriage: marriage) }
  let(:subalbums) { album.albums }
  let(:pictures) { album.pictures }
  let(:first_documents) { documents.limit(per_page) }
  let(:last_documents) { documents.last(documents.count % per_page) }

  context 'when album has only subalbums' do
    it_behaves_like 'a paginator', described_class, :itens do
      let(:subject) { described_class.new(documents, pictures, params) }
      let(:documents) { subalbums }
      let(:documents_with_10_itens) do
        album.tap do |album|
          10.times.each { create(:album, marriage: marriage, album: album) }
        end.albums
      end
      let(:documents_with_more_pages) do
        album.tap do |album|
          (per_page * 2 + 2).times.each { create(:album, marriage: marriage, album: album) }
        end.albums
      end
    end
  end
    
  context 'when album has only pictures' do
    it_behaves_like 'a paginator', described_class, :itens do
      let(:subject) { described_class.new(subalbums, documents, params) }
      let(:documents) { pictures }
      let(:documents_with_10_itens) do
        album.tap do |album|
          10.times.each { create(:picture, album: album) }
        end.pictures
      end
      let(:documents_with_more_pages) do
        album.tap do |album|
          (per_page * 2 + 2).times.each { create(:picture, album: album) }
        end.pictures
      end
    end
  end

  context 'when album has both subalbums and pictures' do
    let(:subject) { described_class.new(subalbums, documents, params) }
    let(:pictures) do
      album.tap do |album|
        pictures_count.times.each { create(:picture, album: album) }
      end.pictures
    end
    let(:subalbums) do
      album.tap do |album|
        albums_count.times.each { create(:album, marriage: marriage, album: album) }
      end.albums
    end

    context 'when pictures and albums fit in a single page' do
      let(:per_page) { 8 }
      let(:params) { { per_page: per_page }  }
      let(:pictures_count) { per_page / 2 }
      let(:albums_count) { per_page / 2 }
      let(:subject) { described_class.new(subalbums, pictures, params) }
      let(:documents_json) { subject.as_json[:itens]  }

      it 'returns both albums and pictures' do
        expect(documents_json.count).to eq(pictures_count + albums_count)
      end
    end
  end
end
