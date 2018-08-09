require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should have_many :availables }
  
  it { should have_many(:products).through(:availables) }
end
