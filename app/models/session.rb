class Session < ApplicationRecord
  has_secure_token :auth_token
  belongs_to :user
end
