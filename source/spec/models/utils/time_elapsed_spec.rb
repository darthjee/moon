# frozen_string_literal: true

require 'spec_helper'

describe Utils::TimeElapsed do
  subject { described_class.new(time) }

  describe '#as_json' do
    shared_examples 'an object that can calculate time ago' do |examples|
      examples.each do |example|
        context 'when time is 10 seconds ago' do
          let(:amount) { example[:amount] }
          let(:unit) { example[:unit] }
          let(:time) { example.delete(:time).ago }
          let(:expected) { example }

          it 'returns the correct time ago' do
            expect(subject.as_json).to eq(expected)
          end
        end
      end
    end

    it_behaves_like 'an object that can calculate time ago', [
      { amount: 0, unit: :second, time: 0.seconds },
      { amount: 30, unit: :second, time: 30.seconds },
      { amount: 1, unit: :minute, time: 1.minute },
      { amount: 1, unit: :minute, time: 70.seconds },
      { amount: 1, unit: :hour, time: 70.minutes },
      { amount: 2, unit: :hour, time: 120.minutes },
      { amount: 1, unit: :day, time: 24.hours },
      { amount: 2, unit: :day, time: 50.hours },
      { amount: 50, unit: :day, time: 50.days },
      { amount: 1, unit: :year, time: 365.days },
      { amount: 1, unit: :year, time: 380.days }
    ]
  end
end
