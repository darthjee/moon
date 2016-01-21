require 'spec_helper'

describe Marriage::Picture::Paginator do
  let(:params) { {} }
  let(:album) { marriage_albums(:first) }
  let(:subject) { described_class.new(album, params) }

  describe '#as_json' do
    it 'returns all the pagination information' do
      expect(subject.as_json.keys).to eq([:pictures, :pages, :page])
    end
  end
end