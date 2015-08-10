require 'spec_helper'

describe Marriage::Common do
  controller do
    include Marriage::Common

    def index
      render('marriage/marriage/show')
    end
  end

  describe 'layout' do
    let(:parameters) { {} }
    before do
      allow(controller).to receive(:render_root)
      get :index, parameters
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
end
