require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should define_enum_for(:status).with [:cart, :pending, :accepted, :declained] }

  it { should have_many(:line_items) }

  it { should have_many(:products).through(:line_items) }

  it { should belong_to(:user) }

  it { should callback(:calculate_total).before(:save) }

  it { should callback(:apt_product_decrement).before(:save).if(:pending?) }

  describe "uniqueness_of_user_id" do
    let(:user) { User.create email: "test@test.com", password: "123456" }

    before { user.orders.create(status: :cart) }

    it { expect { user.orders.create!(status: :cart) }.to raise_error ActiveRecord::RecordInvalid }
  end

  describe "#calculate_total" do
    before { expect(subject).to receive_message_chain(:line_items, :sum).with(no_args).with(:total) }

    it { expect { subject.calculate_total }.to_not raise_error }
  end

  let(:product) { stub_model Product, price: 2 }

  let(:line_item) { stub_model LineItem, product: product, quantity: 3 }

  let(:store) { stub_model Store }

  let(:available) { stub_model Available, quantity: 4, product: product, store: store }

  let(:order) { stub_model Order, line_items: [line_item, line_item] }

  describe "apt_product_decrement" do
    xit { expect{order.pending!}.to change{available.quantity} }
  end
end
