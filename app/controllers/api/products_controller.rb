class Api::ProductsController < ApplicationController
  def index
  end
  
  private
  def collection
    @products ||= Product.all.page(params[:page]).per(10) 
  end 
end
