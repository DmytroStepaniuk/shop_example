class Api::ProductsController < ApplicationController
  private
  def collection
    @products ||= Product.all.page(params[:page]).per(9) 
  end 
end
