require 'spec_helper'

describe Comment::CommentsController do
  let(:requests_json) { load_json_fixture_file('requests/comment/comments.json') }
  let(:parameters) { requests_json[parameters_key] }
  let(:response_json) { JSON.parse response.body }

  describe '#POST create' do
    let(:parameters_key) { 'create' }

    context 'when user do exist' do
      let(:user) { users(:first) }
      it 'updates users name' do
        expect do
          post :create, parameters
        end.to change { User.find(user.id).name }
      end
    end

    context 'when user do not exist' do
      let(:parameters_key) { 'create_new_user' }

      it 'creates a new user' do
        expect do
          post :create, parameters
        end.to change(User, :count)
      end
    end
  end
end
