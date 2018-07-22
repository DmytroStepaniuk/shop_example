require 'rails_helper'

RSpec.describe Api::ProductsController, type: :request do
  it "render paginated products list" do
    get "/api/products"
    expect(response).to render_template(:index)
    expect(response.content_type).to eq("application/json")
    expect(response.body).to include('"collection":')
    expect(response.body).to include('"total_pages":')
    expect(response.body).to include('"total_count":')
  end
end
