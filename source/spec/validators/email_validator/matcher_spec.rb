# frozen_string_literal: true

require 'spec_helper'

describe EmailValidator::Matcher do
  let(:user) { 'user' }
  let(:server) { 'server.com' }
  let(:email) { "#{user}@#{server}" }
  let(:subject) { described_class.new(email) }

  describe '#match' do
    context 'when e-mail is valid' do
      context 'with simple user@server.com format' do
        it { expect(subject.match).to be_truthy }
      end

      context 'when user name is splitted' do
        let(:user) { 'user.name.in' }

        it { expect(subject.match).to be_truthy }

        context 'when the parts are very small' do
          let(:user) { 'a.b.c' }

          it { expect(subject.match).to be_truthy }
        end
      end

      context 'when server is an ip' do
        let(:server) { '12.12.125.100' }

        it { expect(subject.match).to be_truthy }
      end
    end

    context 'when server is invalid' do
      context 'when server lacks type or country' do
        let(:server) { 'server' }

        it { expect(subject.match).to be_falsey }
      end
    end

    context 'when user is invalid' do
      context 'when it starts with a number' do
        let(:user) { '1user' }

        it { expect(subject.match).to be_falsey }
      end

      context 'when it has many dots and underscores' do
        let(:user) { 'aaa..bbb_.ccc' }

        it { expect(subject.match).to be_falsey }
      end

      context 'when after each dot there is a number' do
        let(:user) { 'aaa.1aaa' }

        it { expect(subject.match).to be_falsey }
      end

      context 'when after each underscore there is a number' do
        let(:user) { 'aaa_1aaa' }

        it { expect(subject.match).to be_falsey }
      end

      context 'when after each dot there is nothing' do
        let(:user) { 'aaa.' }

        it { expect(subject.match).to be_falsey }
      end

      context 'when after each underscore there is nothing' do
        let(:user) { 'aaa_' }

        it { expect(subject.match).to be_falsey }
      end

      context 'when it starts with a dash' do
        let(:user) { '_user' }

        it { expect(subject.match).to be_falsey }
      end

      context 'when it starts with a dot' do
        let(:user) { '.user' }

        it { expect(subject.match).to be_falsey }
      end
    end
  end
end
