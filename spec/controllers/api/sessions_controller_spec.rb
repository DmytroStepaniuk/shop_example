require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it { should be_a ApplicationController }

  it { should route(:post, '/api/sessions').to(action: :create, format: :json)  }

  it { should route(:delete, '/api/sessions').to(action: :destroy, format: :json) }

  describe '#create.json' do
    let(:signin) { SignIn.new params.to_unsafe_h }

    context do
      let(:params) { permit!(email: 'test@test.com', password: 'test12') }

      before { expect(SignIn).to receive(:new).with(params).and_return signin }

      before { expect(signin).to receive :save! }

      before { post :create, params: { session: params.to_unsafe_h }, format: :json }

      it { should render_template :create }
    end
  end

  describe '#destroy' do
    before { sign_in }

    let(:session) { stub_model Session }

    before { allow(controller).to receive(:current_session).and_return session }

    before { process :destroy, method: :delete, format: :json }

    it { should respond_with :no_content }
  end
end
