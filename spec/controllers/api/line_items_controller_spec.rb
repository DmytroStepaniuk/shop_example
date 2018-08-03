require 'rails_helper'

RSpec.describe Api::LineItemsController, type: :controller do
  it { should be_a ApplicationController }

  it { should route(:post, '/api/line_items').to(action: :create, format: :json)  }
  
  it { should route(:put, '/api/line_items').to(action: :update, format: :json)  }

  let(:user) { stub_model User }
  
  before { sign_in user }
  
  let(:line_item) { user.cart.line_items.find_or_initialize_by id: 1 }

  let(:params) { { product_id: '111', quantity: '1' } }

  describe '#create.json' do
    before do
      expect(user).to receive_message_chain(:cart, :line_items, :build).
        with(no_args).with(no_args).with(permit! params).
        and_return line_item 
    end
    
    before { expect(line_item).to receive :save! }
    
    before { post :create, params: params, format: :json }

    it { should render_template :create }
  end

  describe '#update.json' do 
    before do
      expect(user).to receive_message_chain(:cart, :line_items, :find_by).
        with(no_args).with(no_args).with(product_id: "111").
        and_return line_item 
    end
    
    before { expect(line_item).to receive(:update!).with(quantity: "1").and_return true }

    before { post :update, params: params, format: :json }

    it { should render_template :update }
  end

  describe '#destroy.json' do
    before do
      expect(user).to receive_message_chain(:cart, :line_items, :find_by).
        with(no_args).with(no_args).with(product_id: "111").
        and_return line_item 
    end

    before { expect(line_item).to receive(:destroy!).and_return true }

    before { delete :destroy, params: params, format: :json }

    it { should render_template :destroy }
  end
end
