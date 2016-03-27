require 'spec_helper'

shared_examples 'a paginator' do |described_class|
  let(:params) { {} }
  let(:album) { marriage_albums(:first) }
  let(:documents) { album.pictures }
  let(:subject) { described_class.new(documents, params) }

  describe '#as_json' do
    let(:documents_json) { subject.as_json[:documents] }
    let(:documents) { Marriage::Picture.where(album_id: album) }

    it 'returns all the pagination information' do
      expect(subject.as_json.keys).to eq([:documents, :pages, :page])
    end

    it 'returns all the documents from the album' do
      expect(documents_json).to eq(documents.as_json)
    end

    context 'when not specifying per page param and having more than one page' do
      before do
        10.times.each { create(:picture, album: album) }
      end

      it 'returns only the first 8 documents' do
        expect(documents_json.length).to eq(8)
      end

      it 'returns page counter bigger than 1' do
        expect(subject.as_json[:pages] > 1).to be_truthy
      end
    end

    context 'when asking for 0 documents per page' do
      let(:per_page) { 0 }
      let(:params) { { per_page: per_page } }
      before do
        10.times.each { create(:picture, album: album) }
      end

      it 'returns all the album documents with no limit' do
        expect(documents_json.length).to eq(Marriage::Picture.where(album: album).count)
      end

      it 'returns only one page' do
        expect(subject.as_json[:pages]).to eq(1)
      end
    end

    context 'when album has more documents than each page can hold' do
      let(:album) { create(:album) }
      let(:last_documents) { 2.times.map { create(:picture, album: album) } }
      let(:first_documents) { per_page.times.map { create(:picture, album: album) } }
      let(:per_page) { 8 }
      let(:page) { nil }
      let(:params) { { per_page: per_page, page: page } }

      before do
        first_documents
        per_page.times.each { create(:picture, album: album) }
        last_documents
      end

      it 'returns the first page documents only' do
        expect(documents_json).to eq(first_documents.as_json)
      end

      context 'when requesting another page' do
        let(:page) { 3 }

        it 'returns the first page documents only' do
          expect(documents_json).to eq(last_documents.as_json)
        end
      end
    end
  end
end
