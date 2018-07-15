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
      before { post :create, params: { session: { email: 'bad@example.com', password: 'keks123' } }, format: :json }

      it { should render_template :errors }
    end
  end
end
