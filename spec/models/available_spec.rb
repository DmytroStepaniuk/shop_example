require 'rails_helper'

RSpec.describe Available, type: :model do
  it { should belong_to :store }
  it { should belong_to :product }
end
