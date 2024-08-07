# frozen_string_literal: true

require 'spec_helper'

shared_examples 'a paginator extending utils paginator' do |klass, key|
  subject { klass.new(documents, params) }

  let(:params) { {} }

  describe '#next_page_offset' do
    let(:per_page) { 8 }
    let(:params) { { per_page: } }
    let(:documents) { documents_with_10_itens }

    context 'when requesting not the last page' do
      it 'returns per page' do
        expect(subject.next_page_offset).to eq(per_page)
      end
    end

    context 'when requesting a page that is not full (the last page)' do
      let(:params) { { page: 2, per_page: } }

      it 'returns the total nunber of documents' do
        expect(subject.next_page_offset).to eq(documents.length)
      end

      context 'when passing offset to fill the page' do
        let(:offset) { 6 }
        let(:params) { { page: 2, offset: -offset, per_page: } }

        it 'returns the real offset plus the given offset' do
          expect(subject.next_page_offset).to eq(documents.length + offset)
        end
      end
    end

    context 'when requesting a page that is after the limits' do
      let(:params) { { page: 3, per_page: } }

      it 'returns the total nunber of documents' do
        expect(subject.next_page_offset).to eq(documents.length)
      end

      context 'when passing offset to fill the page' do
        let(:offset) { 6 }
        let(:params) { { page: 3, offset: -offset, per_page: } }

        it 'returns the real offset plus the given offset' do
          expect(subject.next_page_offset).to eq(documents.length + offset)
        end
      end
    end
  end

  describe '#full_page?' do
    let(:documents) { documents_with_10_itens }

    context 'when requesting not the last page' do
      it do
        expect(subject).to be_full_page
      end
    end

    context 'when requesting a page that is not full (the last page)' do
      let(:params) { { page: 2 } }

      it do
        expect(subject).not_to be_full_page
      end

      context 'when passing offset to fill the page' do
        let(:params) { { page: 2, offset: -6 } }

        it do
          expect(subject).to be_full_page
        end
      end
    end
  end

  it_behaves_like 'a paginator', klass, key
  it_behaves_like 'a paginator that accepts offset', klass, key
end

shared_examples 'a paginator' do |described_class, key|
  subject { described_class.new(documents, params) }

  let(:params) { {} }

  describe '#as_json' do
    let(:documents_json) { subject.as_json[key] }

    it 'returns all the pagination information' do
      expect(subject.as_json.keys.sort).to eq([key, :pages, :page].sort)
    end

    it 'returns all the documents from the list' do
      expect(documents_json).to eq(documents.as_json)
    end

    context 'when not specifying per page param and more than one page' do
      let(:documents) { documents_with_10_itens }

      it 'returns only the first 8 documents' do
        expect(documents_json.length).to eq(8)
      end

      it 'returns page counter bigger than 1' do
        expect(subject.as_json[:pages] > 1).to be_truthy
      end
    end

    context 'when document list is empty' do
      let(:documents) { empty_documents }

      it 'returns at least one page' do
        expect(subject.as_json[:pages]).to eq(1)
      end

      it 'returns first page' do
        expect(subject.as_json[:page]).to eq(1)
      end
    end

    context 'when asking for 0 documents per page' do
      let(:per_page) { 0 }
      let(:params) { { per_page: } }
      let(:documents) { documents_with_10_itens }

      it 'returns all the documents with no limit' do
        expect(documents_json.length).to eq(documents.count)
      end

      it 'returns only one page' do
        expect(subject.as_json[:pages]).to eq(1)
      end

      context 'when given an empty document list' do
        let(:documents) { empty_documents }

        it do
          expect { subject.as_json }.not_to raise_error
        end

        it 'returns at least one page' do
          expect(subject.as_json[:pages]).to eq(1)
        end

        it 'returns first page' do
          expect(subject.as_json[:page]).to eq(1)
        end
      end
    end

    context 'when documents list has more documents than each page can hold' do
      let(:documents) { documents_with_more_pages }
      let(:per_page) { 8 }
      let(:page) { nil }
      let(:params) { { per_page:, page: } }

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

shared_examples 'a paginator that accepts offset' do |described_class, key|
  subject { described_class.new(documents, params) }

  let(:documents_json) { subject.as_json[key] }
  let(:documents) { documents_with_more_pages }
  let(:per_page) { 8 }
  let(:page) { nil }
  let(:params) { { per_page:, page: } }

  describe '#as_json' do
    context 'when passing offset as argument' do
      context 'when the offset is negative' do
        context 'when its module is bigger than per_page argument' do
          let(:offset) { - (per_page + 2) }
          let(:params) { { per_page:, page:, offset: } }

          context 'when requesting the first page' do
            let(:page) { 1 }

            it 'does not return any document' do
              expect(documents_json.length).to eq(0)
            end

            it 'returns the correct pagination' do
              expect(subject.as_json[:page]).to eq(page)
            end

            it 'add the offset to pages count' do
              expect(subject.as_json[:pages]).to eq(4)
            end
          end

          context 'when requesting for a page that is right after the offset' do
            let(:page) { 2 }

            it 'return less documents' do
              expect(documents_json.length).to eq(6)
            end

            it 'returns the correct pagination' do
              expect(subject.as_json[:page]).to eq(page)
            end
          end

          context 'when requesting for a page that is way after the offset' do
            let(:page) { 3 }

            it 'return one page of documents' do
              expect(documents_json.length).to eq(8)
            end

            it 'returns the correct pagination' do
              expect(subject.as_json[:page]).to eq(page)
            end
          end

          context 'when requesting for a page that is after the offset' do
            let(:page) { 4 }

            it 'return last documents' do
              expect(documents_json.length).to eq(4)
            end

            it 'returns the correct pagination' do
              expect(subject.as_json[:page]).to eq(page)
            end
          end

          context 'when document list is empty' do
            let(:documents) { empty_documents }

            context 'when requesting for an unlimited per page list' do
              let(:params) { { per_page: 0, page: 1, offset: } }

              it do
                expect(subject.as_json[:pages]).to eq(1)
              end
            end
          end
        end
      end
    end
  end
end
