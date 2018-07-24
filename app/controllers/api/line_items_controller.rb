class Api::LineItemsController < ApplicationController
  private
  def resource
    @line_item 
  end

  def build_resource
    @line_item = current_user.cart.line_items.build(resource_params)
  end
  
  def resource_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
