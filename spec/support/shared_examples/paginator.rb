require 'spec_helper'

shared_examples 'a paginator' do |described_class, key|
  let(:params) { {} }
  let(:subject) { described_class.new(documents, params) }

  describe '#as_json' do
    let(:documents_json) { subject.as_json[key] }

    it 'returns all the pagination information' do
      expect(subject.as_json.keys).to eq([key, :pages, :page])
    end

    it 'returns all the documents from the list' do
      expect(documents_json).to eq(documents.as_json)
    end

    context 'when not specifying per page param and having more than one page' do
      let(:documents) { documents_with_10_itens }

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
      let(:documents) { documents_with_10_itens }

      it 'returns all the documents with no limit' do
        expect(documents_json.length).to eq(documents.count)
      end

      it 'returns only one page' do
        expect(subject.as_json[:pages]).to eq(1)
      end
    end

    context 'when documents list has more documents than each page can hold' do
      let(:documents) { documents_with_more_pages }
      let(:per_page) { 8 }
      let(:page) { nil }
      let(:params) { { per_page: per_page, page: page } }

      it 'returns the first page documents only' do
        expect(documents_json).to eq(first_documents.as_json)
      end

      context 'when requesting another page' do
        let(:page) { 3 }

        it 'returns the first page documents only' do
          expect(documents_json).to eq(last_documents.as_json)
        end
      end

      context 'when passing offset as argument' do
        context 'when the offset is negative' do
          context 'and its module is bigger than per_page argument' do
            let(:offset) { - (per_page + 2)  }
            let(:params) { { per_page: per_page, page: page, offset: offset } }

            context 'when requesting the first page' do
              let(:page) { 1 }

              it 'does not return any document' do
                expect(documents_json.length).to eq(0)
              end
            end

            context 'when requesting for a page that is after the offset' do
              let(:page) { 2 }

              it 'return less documents' do
                expect(documents_json.length).to eq(6)
              end
            end
          end
        end
      end
    end
  end
end
