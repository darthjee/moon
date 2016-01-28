require 'spec_helper'

describe Admin::Marriage::GiftsController do
  let(:requests_json) { load_json_fixture_file('requests/marriage/gifts.json') }
  let(:parameters) { requests_json[parameters_key] }
  let(:response_json) { JSON.parse(response.body) }

  describe 'POST create' do
    let(:parameters_key) { 'create' }
    let(:last_link) { Marriage::GiftLink.last }
    let(:last_link_attributes) do
      last_link.attributes.slice('url', 'store_list_id', 'gift_id', 'price')
    end
    let(:gift_attributes) { %w(image_url name quantity min_price max_price) }

    before do
      cookies.delete(:admin_key)
    end

    context 'when admin key is wrong' do
      before do
        allow(controller).to receive(:admin_key) { 'abcd' }
      end

      it do
        post :create, parameters
        expect(response).not_to be_success
      end

      context 'but user has admin key on its cookies' do
        before do
          post :create, parameters.merge('admin_key' => 'abcd')
        end

        it do
          post :create, parameters
          expect(response).to be_success
        end
      end
    end

    it do
      post :create, parameters
      expect(response).to be_success
    end

    it do
      expect do
        post :create, parameters
      end.to change { cookies[:admin_key] }
    end

    it do
      expect do
        post :create, parameters
      end.to change(Marriage::Gift, :count)
    end

    it 'creates a gift for the given parameters' do
      post :create, parameters

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
        post :create, parameters
      end.to change(Marriage::GiftLink, :count)
    end

    it 'creates the correct gift link' do
      post :create, parameters

      expect(last_link_attributes).to eq({
        'url' => 'http://gifturl',
        'store_list_id' => 1,
        'gift_id' => Marriage::Gift.last.id,
        'price' => 10.0
      })
    end

    context 'when sending a different size package' do
      let(:parameters_key) { 'create_smaller_package' }

      it 'save the total price correctly' do
        post :create, parameters

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
        post :create, parameters
      end

      it do
        expect do
          post :create, parameters
        end.not_to change(Marriage::GiftLink, :count)
      end

      it do
        expect do
          post :create, parameters
        end.not_to change(Marriage::Gift, :count)
      end

      context 'but for another store' do
        let(:new_request_parameters) { requests_json['create_new_store'] }

        it do
          expect do
            post :create, new_request_parameters
          end.to change(Marriage::GiftLink, :count)
        end

        it do
          expect do
            post :create, new_request_parameters
          end.not_to change(Marriage::Gift, :count)
        end

        it 'updates min and max price for the gift' do

          post :create, new_request_parameters

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
