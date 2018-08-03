class User < ApplicationRecord
  has_secure_password
  
  has_many :sessions, dependent: :destroy
  has_many :orders,   dependent: :destroy
  
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  
  def cart
    self.orders.find_or_initialize_by(status: :cart)
  end
end
