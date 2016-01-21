require 'spec_helper'

describe Marriage::Gift::Paginator do
  let(:params) { {} }
  let(:marriage) { create(:marriage) }
  let(:subject) { described_class.new(marriage, params) }

  describe '#as_json' do
    let(:gifts_json) { subject.as_json[:gifts] }
    let(:gifts) { Marriage::Gift.where(marriage_id: marriage) }

    it 'returns all the pagination information' do
      expect(subject.as_json.keys).to eq([:gifts, :pages, :page])
    end

    it 'returns all the gifts from the marriage' do
      expect(gifts_json).to eq(gifts.as_json)
    end

    context 'when marriage has more gifts than each page can hold' do
      let(:last_gifts) { 2.times.map { create(:gift, marriage: marriage) } }
      let(:first_gifts) { per_page.times.map { create(:gift, marriage: marriage) } }
      let(:per_page) { 8 }
      let(:page) { nil }
      let(:params) { { per_page: per_page, page: page } }

      before do
        first_gifts.each(&:thread)
        per_page.times.map { create(:gift, marriage: marriage) }.each(&:thread)
        last_gifts.each(&:thread)
      end

      it 'returns the first page gifts only' do
        expect(gifts_json).to eq(first_gifts.as_json)
      end

      context 'when requesting another page' do
        let(:page) { 3 }

        it 'returns the first page gifts only' do
          expect(gifts_json).to eq(last_gifts.as_json)
        end
      end
    end
  end
end
