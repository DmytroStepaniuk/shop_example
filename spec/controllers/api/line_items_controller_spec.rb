require 'rails_helper'

RSpec.describe Api::LineItemsController, type: :controller do
  it { should be_a ApplicationController }

  it { should route(:post, '/api/line_items').to(action: :create, format: :json)  }

  describe '#create.json' do
    let(:current_user) { stub_model User }
    
    let(:line_item) { stub_model LineItem }
    
    let(:params) { { product_id: '1', quantity: '1' } }
    
    before { sign_in current_user }
    
    before { expect(subject).to receive(:current_user).and_return current_user }
    
    before do
      expect(current_user).to receive_message_chain(:cart, :line_items, :build).
        with(no_args).with(no_args).with(permit! params).and_return line_item 
    end
    
    before { expect(line_item).to receive :save! }
    
    before { post :create, params: { line_item: params }, format: :json }

    it { should render_template :create }
  end
end
