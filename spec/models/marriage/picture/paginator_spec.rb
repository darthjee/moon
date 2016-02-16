require 'spec_helper'

describe Marriage::Picture::Paginator do
  let(:params) { {} }
  let(:album) { marriage_albums(:first) }
  let(:pictures) { album.pictures }
  let(:subject) { described_class.new(pictures, params) }

  describe '#as_json' do
    let(:pictures_json) { subject.as_json[:pictures] }
    let(:pictures) { Marriage::Picture.where(album_id: album) }

    it 'returns all the pagination information' do
      expect(subject.as_json.keys).to eq([:pictures, :pages, :page])
    end

    it 'returns all the pictures from the album' do
      expect(pictures_json).to eq(pictures.as_json)
    end

    context 'when not specifying per page param and having more than one page' do
      before do
        10.times.each { create(:picture, album: album) }
      end

      it 'returns only the first 8 pictures' do
        expect(pictures_json.length).to eq(8)
      end

      it 'returns page counter bigger than 1' do
        expect(subject.as_json[:pages] > 1).to be_truthy
      end
    end

    context 'when asking for 0 pictures per page' do
      let(:per_page) { 0 }
      let(:params) { { per_page: per_page } }
      before do
        10.times.each { create(:picture, album: album) }
      end

      it 'returns all the album pictures with no limit' do
        expect(pictures_json.length).to eq(Marriage::Picture.where(album: album).count)
      end

      it 'returns only one page' do
        expect(subject.as_json[:pages]).to eq(1)
      end
    end

    context 'when album has more pictures than each page can hold' do
      let(:album) { create(:album) }
      let(:last_pictures) { 2.times.map { create(:picture, album: album) } }
      let(:first_pictures) { per_page.times.map { create(:picture, album: album) } }
      let(:per_page) { 8 }
      let(:page) { nil }
      let(:params) { { per_page: per_page, page: page } }

      before do
        first_pictures
        per_page.times.each { create(:picture, album: album) }
        last_pictures
      end

      it 'returns the first page pictures only' do
        expect(pictures_json).to eq(first_pictures.as_json)
      end

      context 'when requesting another page' do
        let(:page) { 3 }

        it 'returns the first page pictures only' do
          expect(pictures_json).to eq(last_pictures.as_json)
        end
      end
    end
  end
end
