# frozen_string_literal: true

require 'spec_helper'

describe Marriage::Album::Paginator do
  it_behaves_like 'a paginator extending utils paginator',
                  described_class, :albums do
    let(:marriage) { marriage_marriages(:first) }
    let(:documents) { marriage.albums }
    let(:documents_with_10_itens) do
      create(:marriage).tap do |marriage|
        10.times.each { create(:album, marriage: marriage) }
      end.albums
    end
    let(:documents_with_more_pages) do
      create(:marriage).tap do |marriage|
        (per_page * 2 + 2).times.each { create(:album, marriage: marriage) }
      end.albums
    end
    let(:empty_documents) { create(:marriage).albums }
    let(:first_documents) { documents.limit(per_page) }
    let(:last_documents) { documents.last(documents.count % per_page) }
  end
end
