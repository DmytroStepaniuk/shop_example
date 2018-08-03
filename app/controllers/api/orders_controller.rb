class Api::OrdersController < ApplicationController
  
  def create
    current_user.cart.pending!
  end
  
end