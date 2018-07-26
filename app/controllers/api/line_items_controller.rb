class Api::LineItemsController < ApplicationController

  def update
    resource.update!(quantity: params[:quantity]) 
  end
  
  private

  def resource
    @line_item ||= current_user.cart.line_items.find_by product_id: params[:product_id]
  end

  def build_resource
    @line_item = current_user.cart.line_items.build(resource_params)
  end

  def resource_params
    params.permit(:product_id, :quantity)
  end
end
