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

      context 'when requesting last page' do
        let(:page) { 3 }

        it 'returns the last page gifts only' do
          expect(gifts_json).to eq(last_gifts.as_json)
        end
      end

      context 'when there are gifts to be ordered by name' do
        let(:real_first_gifts) { per_page.times.map { create(:gift, marriage: marriage, name: 'aaa') } }
        let(:last_gifts) { 2.times.map { create(:gift, marriage: marriage, name: 'zzz') } }

        before do
          real_first_gifts.each(&:thread)
        end

        it 'returns the first page gifts ordered by name' do
          expect(gifts_json).to match_array(real_first_gifts.as_json)
        end

        context 'when requesting last page' do
          let(:page) { 4 }

          it 'returns the last page gifts only ordered by name' do
            expect(gifts_json).to match_array(last_gifts.as_json)
          end
        end

        context 'when requesting for specific ordering' do
          let(:params) do
            { per_page: per_page, page: page, sort_direction: direction, sort_by: sort_by}
          end

          context 'when oredering by name' do
            let(:sort_by) { 'name' }

            context 'descending' do
              let(:direction) { 'desc' }
              let(:per_page) { 2 }

              it 'returns first page ordered by name' do
                expect(gifts_json).to match_array(last_gifts.as_json)
              end
            end

            context 'ascending' do
              let(:direction) { 'asc' }

              it 'returns first page ordered by name' do
                expect(gifts_json).to match_array(real_first_gifts.as_json)
              end
            end
          end

          context 'when oredering by price' do
            let(:sort_by) { 'price' }
            before do
              marriage.gifts.order(:id).each.with_index do |g, i|
                g.update(min_price: i, max_price: 1000 - i)
              end
              first_gifts.each(&:reload)
              last_gifts.each(&:reload)
            end

            context 'descending' do
              let(:direction) { 'desc' }

              it 'returns first page ordered by name' do
                expect(gifts_json).to match_array(first_gifts.as_json)
              end
            end

            context 'ascending' do
              let(:direction) { 'asc' }

              it 'returns first page ordered by name' do
                expect(gifts_json).to match_array(first_gifts.as_json)
              end
            end
          end
        end
      end
    end
  end
end
