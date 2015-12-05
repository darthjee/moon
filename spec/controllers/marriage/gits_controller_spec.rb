require 'spec_helper'

describe Marriage::GiftsController do
  let(:requests_json) { load_json_fixture_file('requests/marriage/gifts.json') }
  let(:parameters) { requests_json[parameters_key] }
  let(:response_json) { JSON.parse(response.body) }

  describe 'POST create' do
    let(:parameters_key) { 'create' }
    let(:last_link) { Marriage::GiftLink.last }

    it do
      post :create, parameters
      expect(response).to be_success
    end

    it do
      expect do
        post :create, parameters
      end.to change(Marriage::Gift, :count)
    end

    it 'creates a gift for the given parameters' do
      post :create, parameters

      expect(Marriage::Gift.last.attributes.slice('image_url', 'name')).to eq(
        'image_url' => 'http://image_url.com',
        'name' => 'Gift Name'
      )
    end

    it do
      expect do
        post :create, parameters
      end.to change(Marriage::GiftLink, :count)
    end

    it 'creates the correct gift link' do
      post :create, parameters

      expect(last_link.attributes.slice('url', 'store_list_id', 'gift_id')).to eq({
        'url' => 'http://gifturl',
        'store_list_id' => 1,
        'gift_id' => Marriage::Gift.last.id
      })
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
        before do
          Marriage::GiftLink.last.update(store_list_id: 2)
        end

        it do
          expect do
            post :create, parameters
          end.to change(Marriage::GiftLink, :count)
        end

        it do
          expect do
            post :create, parameters
          end.not_to change(Marriage::Gift, :count)
        end
      end
    end
  end
end
