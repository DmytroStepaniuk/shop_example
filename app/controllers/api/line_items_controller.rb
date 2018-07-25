class Api::LineItemsController < ApplicationController

  def update
    item = current_user.cart.line_items.find_by_product_id product_id
    
    quantity < "1" ?  item.destroy! : item.update!(quantity: quantity) 

    head :ok
  end
  
  private

  def resource
    @line_item 
  end

  def build_resource
    @line_item = current_user.cart.line_items.build(resource_params)
  end
  
  def quantity
    resource_params[:quantity]
  end

  def product_id
    resource_params[:product_id]
  end

  def resource_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
