require 'spec_helper'

describe Marriage::Common do
  let(:parameters) { {} }
  controller do
    include Marriage::Common

    def index
      respond_to do |format|
        format.html { render('marriage/marriage/show') }
        format.json { render body: nil }
      end
    end
  end

  describe 'layout' do
    before do
      allow(controller).to receive(:is_home?) { true }
      get :index, params: parameters
    end

    it do
      expect(response).to render_template('layouts/marriage')
    end

    context 'when requesting an ajax request' do
      let(:parameters) { { ajax: true } }

      it do
        expect(response).not_to render_template('layouts/marriage')
      end
    end
  end

  describe 'angular redirection' do
    before do
      get :index, params: parameters
    end

    it 'redirects to root with angular route' do
      expect(response).to redirect_to('http://test.host#/anonymous')
    end

    context 'when requesting a json request' do
      let(:parameters) { { format: :json } }

      it do
        expect(response).not_to be_a_redirect
      end
    end

    context 'when it is an ajax redirection' do
      let(:parameters) { { ajax: true } }

      it do
        expect(response).not_to be_a_redirect
      end
    end
  end
end
