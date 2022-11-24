class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update upvote]

  def index
    @products = Product.all

    render :index
  end

  def show
    render :show
  end

  def upvote
    @product.increment!(:upvotes)

    render :show
  end

  def update
    if @product.update(product_params)
      render :show
    else
      render_errors(@product)
    end
  end

  def count
    @planned = Product.where(status: :planned).count
    @live = Product.where(status: :live).count
    @in_progress = Product.where(status: :in_progress).count
    @suggestion = Product.where(status: :suggestion).count

    render :count
  end

  def suggestions
    @products = products_by_status(:suggestion)

    render :index
  end

  def planned
    @products = products_by_status(:planned)

    render :index
  end

  def live
    @products = products_by_status(:live)

    render :index
  end

  def in_progress
    @products = products_by_status(:in_progress)

    render :index
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found(Product, params[:id]) if @product.nil?
  end

  def product_params
    params.permit(:title, :description, :category, :status, :upvotes)
  end

  def products_by_status(status)
    Product.where(status: status)
  end
end
