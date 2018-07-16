class User < ApplicationRecord
  has_secure_password
  has_many :sessions
  
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
