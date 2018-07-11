class User < ApplicationRecord
  has_secure_password
  has_many :sessions
  
  validates_length_of :password, minimum: 6
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
