# frozen_string_literal: true

require 'spec_helper'

describe Marriage::Gift::Creator do
  let(:parameters) { ActionController::Parameters.new(parameters_json) }
  let(:marriage) { create(:marriage) }
  let(:subject) { described_class.new(marriage, parameters) }
  let(:store)   { create(:store) }
  let!(:store_list) { create(:store_list, marriage: marriage, store: store) }
  let(:gift) { build(:gift) }
  let(:gift_links) { [gift_link] }
  let(:gift_link) do
    build(:gift_link, gift: gift)
  end

  describe '#create' do
    let(:parameters_json) do
      create(:marriage_gift_create, marriage: marriage, gift_links: gift_links, store: store)
    end
    let(:last_link) { Marriage::GiftLink.last }
    let(:last_link_attributes) do
      last_link.attributes.slice('url', 'store_list_id', 'gift_id', 'price')
    end
    let(:gift_attributes) { %w[image_url name quantity min_price max_price] }

    it do
      expect do
        subject.create
      end.to change(Marriage::Gift.unscoped, :count)
    end

    it 'creates a gift for the given parameters' do
      subject.create

      expect(Marriage::Gift.last.attributes.slice(*gift_attributes)).to eq(
        'image_url' => gift.image_url,
        'name' => gift.name,
        'quantity' => gift.quantity,
        'min_price' => gift_link.price,
        'max_price' => gift_link.price
      )
    end

    it do
      expect do
        subject.create
      end.to change(Marriage::GiftLink.unscoped, :count)
    end

    it do
      expect do
        subject.create
      end.to change(Comment::Thread.unscoped, :count)
    end

    it 'creates the correct gift link' do
      subject.create

      expect(last_link_attributes)
        .to eq({
          'url' => gift_link.url,
          'store_list_id' => store_list.id,
          'gift_id' => Marriage::Gift.last.id,
          'price' => gift_link.price
        })
    end

    context 'when sending a different size package' do
      let(:gift) { build(:gift, package: 10) }

      it 'save the total price correctly' do
        subject.create

        expect(Marriage::Gift.last.attributes.slice(*gift_attributes)).to eq(
          'image_url' => gift.image_url,
          'name' => gift.name,
          'quantity' => gift.quantity,
          'min_price' => gift_link.price * gift.package,
          'max_price' => gift_link.price * gift.package,
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
        end.not_to change(Marriage::GiftLink.unscoped, :count)
      end

      it do
        expect do
          subject.create
        end.not_to change(Marriage::Gift.unscoped, :count)
      end

      context 'but it has changed its name' do
        before do
          Marriage::Gift.last.update(name: 'new gift name')
        end

        it do
          expect do
            subject.create
          end.not_to change(Marriage::Gift.unscoped, :count)
        end

        it do
          expect do
            subject.create
          end.not_to change(Marriage::GiftLink.unscoped, :count)
        end
      end

      context 'but it has been already canceled' do
        before do
          Marriage::Gift.last.cancel
        end

        it do
          expect do
            subject.create
          end.not_to change(Marriage::Gift.unscoped, :count)
        end

        it do
          expect do
            subject.create
          end.not_to change(Marriage::GiftLink.unscoped, :count)
        end
      end

      context 'and we are updating the bought quantity' do
        let(:gift) { create(:gift, marriage: marriage, bought: 0, quantity: 4) }
        let(:update_gifts_creator) do
          described_class.new(marriage, update_request_parameters)
        end
        let(:update_request_parameters) do
          ActionController::Parameters.new update_parameters_json
        end
        let(:update_parameters_json) do
          create(
            :marriage_gift_update,
            marriage: marriage, gift_links: gift_links, store: store,
            bought: 4
          )
        end

        it 'updates the bought quantity' do
          expect { update_gifts_creator.create }
            .to(change { Marriage::Gift.find(gift.id).bought })
        end

        it 'updates the bought status' do
          expect { update_gifts_creator.create }
            .to change { Marriage::Gift.find(gift.id).status }
            .to('bought')
        end

        it do
          expect { update_gifts_creator.create }
            .not_to change(Marriage::GiftLink.unscoped, :count)
        end
      end

      context 'but for another store' do
        let(:new_gifts_creator) do
          described_class.new(marriage, new_request_parameters)
        end
        let(:new_request_parameters) do
          ActionController::Parameters.new(create_new_parameters_json)
        end
        let(:new_store) { create(:store) }
        let(:create_new_parameters_json) do
          create(
            :marriage_gift_create,
            marriage: marriage, gift_links: gift_links, store: new_store
          )
        end

        it do
          expect do
            new_gifts_creator.create
          end.to change(Marriage::GiftLink.unscoped, :count)
        end

        it do
          expect do
            new_gifts_creator.create
          end.not_to change(Marriage::Gift.unscoped, :count)
        end

        it 'updates min and max price for the gift' do
          new_gifts_creator.create

          expect(Marriage::Gift.last.attributes.slice(*gift_attributes)).to eq(
            'image_url' => gift.image_url,
            'name' => gift.name,
            'quantity' => gift.quantity,
            'min_price' => gift_link.price,
            'max_price' => gift_link.price
          )
        end
      end
    end
  end
end
