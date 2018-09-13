class Api::OrdersController < ApplicationController

  def create
    OrderHandler.new(current_user).pending!
  end

end