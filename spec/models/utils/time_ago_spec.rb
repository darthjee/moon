require 'spec_helper'

describe Utils::TimeAgo do
  let(:subject) { described_class.new(time) }

  describe '#as_json' do
    shared_examples 'an object that can calculate time ago' do |examples|
      examples.each do |example|
        context 'when time is 10 seconds ago' do
          let(:amount) { example[:amount] }
          let(:unit) { example[:unit] }
          let!(:time) { example.delete(:time).ago }
          let(:expected) { example }

          it 'returns the correct time ago' do
            expect(subject.as_json).to eq(expected)
          end
        end
      end
    end

    it_behaves_like 'an object that can calculate time ago', [
      { amount: 10, unit: :seconds, time: 10.seconds },
      { amount: 1, unit: :minutes, time: 60.seconds }
    ]
  end
end