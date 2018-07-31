require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many :line_items }
  it { should have_many(:orders).through(:line_items) }
end
