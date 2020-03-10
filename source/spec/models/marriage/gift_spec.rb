require 'spec_helper'

describe Marriage::Gift do
  describe '#cancel' do
    let(:gift) { marriage_gifts(:first_gift) }
    let(:gift_links_ids) { gift.gift_links.pluck(:id) }

    it do
      expect do
        gift.cancel
      end.to change { Marriage::GiftLink.where(id: gift_links_ids).count }
    end

    it 'clears the links as well' do
      gift.cancel
      gift.reload
      expect(gift.gift_links).to be_empty
    end
  end

  describe '#thread' do
    let(:subject) { create :gift }

    context 'when gift does not have a thread' do
      it 'creates a new thread' do
        expect do
          subject.thread
        end.to change(Comment::Thread, :count).by(1)
      end

      it 'creates a new thread and relates it to comment' do
        expect do
          subject.thread
        end.to change(subject, :thread_id)
      end

      it 'creates a new thread only once' do
        expect do
          subject.thread
          subject.thread
        end.to change(Comment::Thread, :count).by(1)
      end
    end
  end
end
