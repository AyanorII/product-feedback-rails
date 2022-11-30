class Api::V1::CommentsController < ApplicationController
  def index
    product = Product.find(params[:product_id])
    @comments = Comment.where(product: product, parent: nil)
    render :index
  end
end
