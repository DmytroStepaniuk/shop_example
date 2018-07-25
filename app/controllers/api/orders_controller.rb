class Api::OrdersController < ApplicationController
  
  def create
    current_user.cart.update(status: :pending)
    head :ok
  end
  
end