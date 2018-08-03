require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  it { should be_a ApplicationController }

  it { should route(:post, '/api/orders').to(action: :create, format: :json)  }

  let(:user) { stub_model User }
  
  before { sign_in user }
  
  let(:line_item) { user.cart.line_items.find_or_initialize_by id: 1 }

  describe '#create.json' do
    before do
      expect(user).to receive_message_chain(:cart, :pending!).
        with(no_args).with(no_args)
    end
    
    before { post :create, format: :json }

    it { should render_template :create }
  end

end
