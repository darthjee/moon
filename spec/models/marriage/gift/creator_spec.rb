require 'spec_helper'

describe Marriage::Gift::Creator do
  let(:tests_json) { load_json_fixture_file('requests/marriage/gifts.json') }
  let(:parameters_json) { tests_json[test_key].slice('gift_links', 'store_id') }
  let(:parameters) { ActionController::Parameters.new(parameters_json) }
  let(:marriage) { marriage_marriages(:first) }
  let(:subject) { described_class.new(marriage, parameters) }

  describe '#create' do
    let(:test_key) { 'create' }
    let(:last_link) { Marriage::GiftLink.last }
    let(:last_link_attributes) do
      last_link.attributes.slice('url', 'store_list_id', 'gift_id', 'price')
    end
    let(:gift_attributes) { %w(image_url name quantity min_price max_price) }

    it do
      expect do
        subject.create
      end.to change(Marriage::Gift, :count)
    end

    it 'creates a gift for the given parameters' do
      subject.create

      expect(Marriage::Gift.last.attributes.slice(*gift_attributes)).to eq(
        'image_url' => 'http://image_url.com',
        'name' => 'Gift Name',
        'quantity' => 4,
        'min_price' => 40.0,
        'max_price' => 40.0
      )
    end

    it do
      expect do
        subject.create
      end.to change(Marriage::GiftLink, :count)
    end

    it 'creates the correct gift link' do
      subject.create

      expect(last_link_attributes).to eq({
        'url' => 'http://gifturl',
        'store_list_id' => 1,
        'gift_id' => Marriage::Gift.last.id,
        'price' => 10.0
      })
    end

    context 'when sending a different size package' do
      let(:test_key) { 'create_smaller_package' }

      it 'save the total price correctly' do
        subject.create

        expect(Marriage::Gift.last.attributes.slice(*gift_attributes)).to eq(
          'image_url' => 'http://image_url.com',
          'name' => 'Gift Name',
          'quantity' => 4,
          'min_price' => 20.0,
          'max_price' => 20.0
        )

      end
    end

    context 'when gift already exists' do
      before do
        described_class.new(marriage, parameters).create
      end

      it do
        expect do
          subject.create
        end.not_to change(Marriage::GiftLink, :count)
      end

      it do
        expect do
          subject.create
        end.not_to change(Marriage::Gift, :count)
      end

      context 'but for another store' do
        let(:new_request_parameters) { ActionController::Parameters.new tests_json['create_new_store'] }

        it do
          expect do
            described_class.new(marriage, new_request_parameters).create
          end.to change(Marriage::GiftLink, :count)
        end

        it do
          expect do
            described_class.new(marriage, new_request_parameters).create
          end.not_to change(Marriage::Gift, :count)
        end

        it 'updates min and max price for the gift' do

          described_class.new(marriage, new_request_parameters).create

          expect(Marriage::Gift.last.attributes.slice(*gift_attributes)).to eq(
            'image_url' => 'http://image_url.com',
            'name' => 'Gift Name',
            'quantity' => 4,
            'min_price' => 40.0,
            'max_price' => 80.0
          )
        end
      end
    end
  end
end