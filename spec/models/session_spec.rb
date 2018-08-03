require 'rails_helper'

RSpec.describe Session, type: :model do
  it { should belong_to :user }
  xit { should have_secure_token :auth_token }
end
