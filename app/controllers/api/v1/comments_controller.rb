class Api::V1::CommentsController < ApplicationController
  def index
    product = Product.find(params[:product_id])
    @comments = product.comments

    render :index
  end
end
