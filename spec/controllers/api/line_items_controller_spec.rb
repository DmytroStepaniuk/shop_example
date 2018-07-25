require 'rails_helper'

RSpec.describe Api::LineItemsController, type: :controller do
  it { should be_a ApplicationController }

  it { should route(:post, '/api/line_items').to(action: :create, format: :json)  }
  
  it { should route(:put, '/api/line_items').to(action: :update, format: :json)  }

  let(:current_user) { stub_model User }
  
  before { sign_in current_user }
  
  let(:line_item) { stub_model LineItem }

  let(:params) { { product_id: '1', quantity: '1' } }

  describe '#create.json' do
    before { expect(subject).to receive(:current_user).and_return current_user }
    
    before do
      expect(current_user).to receive_message_chain(:cart, :line_items, :build).
        with(no_args).with(no_args).with(permit! params).
        and_return line_item 
    end
    
    before { expect(line_item).to receive :save! }
    
    before { post :create, params: { line_item: params }, format: :json }

    it { should render_template :create }
  end

  describe '#update' do
    let(:item) { line_item }
    before do
      expect(current_user).
        to receive_message_chain(:cart, :line_items, :find_by_product_id).
        with(no_args).with(no_args).with("1").
        and_return line_item 
    end

    # context do  
    #   before { expect("1").to receive(:<).with("1").and_return true }

    #   before do
    #     expect { post :update, params: { line_item: params }, format: :json  }
    #       .to change(LineItem, :count).by(-1) 
    #   end 

    #   it { should respond_with :ok }
    # end

    context do  
      before { expect("1").to receive(:<).with("1").and_return false }

      before { post :update, params: { line_item: params }, format: :json }

      before { expect(line_item.quantity).to eq(1) }

      it { should respond_with :ok }
    end
  end
end
