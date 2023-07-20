# frozen_string_literal: true

require 'spec_helper'

describe User::Decorator do
  subject(:decorator) { described_class.new(object) }

  let(:object) { user }
  let!(:user)  { create(:user) }

  describe '#as_json' do
    let(:expected_json) do
      {
        id: user.id,
        name: user.name,
        login: user.login,
        email: user.email
      }.stringify_keys
    end

    it 'returns meta data defined json' do
      expect(decorator.as_json).to eq(expected_json)
    end

    context 'when object is an collecton' do
      let(:object) { User.all }

      let(:expected_json) do
        object.map do |obj|
          obj.attributes.select do |key, _|
            %w[email id login name].include?(key)
          end
        end
      end

      it 'returns meta data defined json' do
        expect(decorator.as_json).to eq(expected_json)
      end
    end

    context 'when user is invalid' do
      let!(:user) { build(:user, email: 'wrong') }

      let(:expected_json) do
        {
          id: user.id,
          name: user.name,
          login: user.login,
          email: user.email,
          errors: {
            email: ["is invalid"]
          }
        }.deep_stringify_keys
      end

      before { user.valid? }

      it 'include errors' do
        expect(decorator.as_json).to eq(expected_json)
      end
    end
  end
end
