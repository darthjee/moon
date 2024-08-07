# frozen_string_literal: true

require 'spec_helper'

describe Marriage::Gift::Paginator do
  subject { described_class.new(gifts, params) }

  it_behaves_like 'a paginator extending utils paginator',
                  described_class, :gifts do
    let(:marriage) { marriage_marriages(:first) }
    let(:documents) { marriage.gifts.order(:name).tap { |l| l.each(&:thread) } }
    let(:documents_with_10_itens) do
      create(:marriage).tap do |marriage|
        create_list(:gift, 10, marriage:).each(&:thread)
      end.gifts
    end
    let(:documents_with_more_pages) do
      create(:marriage).tap do |marriage|
        ((per_page * 2) + 2).times.map do
          create(:gift, marriage:)
        end.each(&:thread)
      end.gifts
    end
    let(:empty_documents) { create(:marriage).gifts }
    let(:first_documents) { documents.order(:name).limit(per_page) }
    let(:last_documents) { documents.last(documents.count % per_page) }
  end

  let(:params) { {} }
  let(:marriage) { create(:marriage) }
  let(:gifts) { marriage.gifts }

  describe '#as_json' do
    let(:gifts_json) { subject.as_json[:gifts] }
    let(:gifts) { Marriage::Gift.where(marriage_id: marriage) }

    context 'when marriage has more gifts than each page can hold' do
      let(:last_gifts) { create_list(:gift, 2, marriage:) }
      let(:first_gifts) { create_list(:gift, per_page, marriage:) }
      let(:per_page) { 8 }
      let(:page) { nil }
      let(:params) { { per_page:, page: } }

      before do
        first_gifts.each(&:thread)
        create_list(:gift, per_page, marriage:).each(&:thread)
        last_gifts.each(&:thread)
      end

      context 'when there are gifts to be ordered by name' do
        let(:real_first_gifts) do
          create_list(:gift, per_page, marriage:, name: 'aaa')
        end
        let(:last_gifts) do
          create_list(:gift, 2, marriage:, name: 'zzz')
        end

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
            {
              per_page:,
              page:,
              sort_direction: direction,
              sort_by:
            }
          end

          context 'when oredering by name' do
            let(:sort_by) { 'name' }

            context 'when descending' do
              let(:direction) { 'desc' }
              let(:per_page) { 2 }

              it 'returns first page ordered by name' do
                expect(gifts_json).to match_array(last_gifts.as_json)
              end
            end

            context 'when ascending' do
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

            context 'when descending' do
              let(:direction) { 'desc' }

              it 'returns first page ordered by name' do
                expect(gifts_json).to match_array(first_gifts.as_json)
              end
            end

            context 'when ascending' do
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
