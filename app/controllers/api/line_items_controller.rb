class Api::LineItemsController < ApplicationController

  def update
    resource.update!(quantity: params[:quantity])
  end

  private

  def resource
    @line_item ||= current_user.cart.line_items.find_by product_id: params[:product_id]
  end

  def build_resource
    c = current_user.cart
    c.kind = params[:order_kind]
    c.store = params[:store] if c.offline?
    #c.store = Store.order(:priority).first
    #if update quantity greater then is in store take next store(create order?)
    c.save!
    @line_item = current_user.cart.line_items.build(resource_params)
  end

  def resource_params
    params.permit(:product_id, :quantity)
  end
end
