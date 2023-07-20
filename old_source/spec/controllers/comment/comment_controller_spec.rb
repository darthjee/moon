# frozen_string_literal: true

require 'spec_helper'

describe Comment::CommentsController do
  let(:parameters) { requests_json[parameters_key] }
  let(:response_json) { JSON.parse response.body }
  let(:requests_json) do
    load_json_fixture_file('requests/comment/comments.json')
  end

  describe '#POST create' do
    let(:parameters_key) { 'create' }
    let(:thread) { comment_threads(:first) }

    context 'when user do exist' do
      let(:user) { users(:first) }
      it 'updates users name' do
        expect { post :create, params: parameters }
          .to(change { User.find(user.id).name })
      end

      it 'creates a new comment' do
        expect { post :create, params: parameters }
          .to(change { Comment::Thread.find(thread.id).comments.count })
      end

      it 'associates user with comment' do
        post :create, params: parameters
        expect(thread.comments.unscoped.order(id: :asc).last.user).to eq(user)
      end
    end

    context 'when user do not exist' do
      let(:parameters_key) { 'create_new_user' }

      it 'creates a new user' do
        expect do
          post :create, params: parameters
        end.to change(User, :count)
      end

      it 'creates a new comment' do
        expect { post :create, params: parameters }
          .to(change { Comment::Thread.find(thread.id).comments.count })
      end
    end

    context 'when user email is wrong' do
      let(:parameters_key) { 'create_wrong_email' }

      it 'does not create a new user' do
        expect do
          post :create, params: parameters
        end.not_to change(User, :count)
      end

      it 'does not create a new comment' do
        expect do
          post :create, params: parameters
        end.not_to change(Comment::Comment, :count)
      end

      it 'returns error' do
        patch :create, params: parameters
        expect(response_json).to have_key('errors')
        expect(response_json['errors']).to have_key('user')
        expect(response_json['errors']['user']).to have_key('email')
      end

      it do
        patch :create, params: parameters
        expect(response).not_to be_success
      end
    end
  end
end
