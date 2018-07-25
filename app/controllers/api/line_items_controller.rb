class Api::LineItemsController < ApplicationController

  def update
    item = current_user.cart.line_items.find_by_product_id(params[:product_id])
    
    params[:quantity] < "1" ?  item.destroy! : item.update!(quantity: params[:quantity]) 

    head :ok
  end
  
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
