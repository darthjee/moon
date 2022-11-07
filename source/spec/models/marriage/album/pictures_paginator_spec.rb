# frozen_string_literal: true

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
      let(:empty_documents) { create(:album).albums }
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
      let(:empty_documents) { create(:album).pictures }
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
    let(:documents_json) { subject.as_json[:itens] }
    let(:per_page) { 8 }
    let(:page) { 1 }
    let(:params) { { per_page: per_page, page: page } }
    let(:subject) { described_class.new(subalbums, pictures, params) }

    context 'when pictures and albums fit in a single page' do
      let(:pictures_count) { per_page / 2 }
      let(:albums_count) { per_page / 2 }

      it 'returns both albums and pictures' do
        expect(documents_json.count).to eq(pictures_count + albums_count)
      end

      it 'returns one page count' do
        expect(subject.as_json[:pages]).to eq(1)
      end

      it 'returns the page as given' do
        expect(subject.as_json[:page]).to eq(page)
      end
    end

    context 'when they do not fit in a single page' do
      context 'fiting in one page each' do
        let(:pictures_count) { per_page }
        let(:albums_count) { per_page }

        it 'returns both albums and pictures' do
          expect(documents_json.count).to eq(per_page)
        end

        context 'when requesting the first page' do
          it 'returns the albums fist' do
            expect(documents_json).to eq(subalbums.as_json)
          end

          it 'returns one page count' do
            expect(subject.as_json[:pages]).to eq(2)
          end

          it 'returns the page as given' do
            expect(subject.as_json[:page]).to eq(page)
          end
        end

        context 'when requesting the second page' do
          let(:page) { 2 }
          it 'returns the pictures' do
            expect(documents_json).to eq(pictures.as_json)
          end

          it 'returns one page count' do
            expect(subject.as_json[:pages]).to eq(2)
          end

          it 'returns the page as given' do
            expect(subject.as_json[:page]).to eq(page)
          end
        end
      end

      context 'fiting in a total of 3 pages' do
        let(:pictures_count) { per_page * 3 / 2 }
        let(:albums_count) { per_page * 3 / 2 }

        context 'when requesting the first page' do
          it 'returns the first albums fist' do
            expect(documents_json).to eq(subalbums.limit(per_page).as_json)
          end

          it 'returns one page count' do
            expect(subject.as_json[:pages]).to eq(3)
          end

          it 'returns the page as given' do
            expect(subject.as_json[:page]).to eq(page)
          end
        end

        context 'when requesting the middle page' do
          let(:page) { 2 }
          let(:albums_expected) { subalbums.offset(per_page).as_json }
          let(:pictures_expected) { pictures.limit(per_page / 2).as_json }
          let(:list_expected) { albums_expected + pictures_expected }

          it 'returns albums first' do
            expect(documents_json).to eq(list_expected)
          end

          it 'returns one page count' do
            expect(subject.as_json[:pages]).to eq(3)
          end

          it 'returns the page as given' do
            expect(subject.as_json[:page]).to eq(page)
          end
        end

        context 'when requesting the last page' do
          let(:page) { 3 }

          it 'returns the last pictures' do
            expect(documents_json).to eq(pictures.offset(per_page / 2).as_json)
          end

          it 'returns one page count' do
            expect(subject.as_json[:pages]).to eq(3)
          end

          it 'returns the page as given' do
            expect(subject.as_json[:page]).to eq(page)
          end
        end

        context 'when requesting no page limit' do
          let(:per_page) { 0 }

          it 'returns the last pictures' do
            expect(documents_json).to eq(subalbums.as_json + pictures.as_json)
          end

          it 'returns one page count' do
            expect(subject.as_json[:pages]).to eq(1)
          end

          it 'returns the page as given' do
            expect(subject.as_json[:page]).to eq(page)
          end
        end
      end
      context 'fiting in a total of 4 not fully pagespages' do
        let(:pictures_count) { per_page * 3 / 2 + 1 }
        let(:albums_count) { per_page * 3 / 2 + 1 }
        let(:page) { 4 }

        it 'returns the last pictures' do
          expect(documents_json).to eq(pictures.offset(per_page * 3 / 2 - 1).as_json)
        end

        it 'returns one page count' do
          expect(subject.as_json[:pages]).to eq(4)
        end

        it 'returns the page as given' do
          expect(subject.as_json[:page]).to eq(page)
        end
      end
    end
  end
end
