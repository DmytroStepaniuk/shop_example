require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it { should be_a ApplicationController }

  it { should route(:post, '/api/sessions').to(action: :create, format: :json)  }

  it { should route(:delete, '/api/sessions').to(action: :destroy, format: :json) }

  describe '#create.json' do
    before { User.create email: 'test@test.com', password: 'test12' }

    context do
      before { post :create, params: { session: { email: 'test@test.com', password: 'test12' } }, format: :json }

      it { should render_template :create }
    end

    context do
      before { post :create, params: { session: { email: 'error@error.com', password: 'error' } }, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#destroy' do
    before { sign_in }

    let(:session) { stub_model Session }

    before { allow(controller).to receive(:current_session).and_return session }

    before { expect(session).to receive :destroy! }

    before { process :destroy, method: :delete, params: { format: :json } }

    it { should respond_with :no_content }
  end
end
