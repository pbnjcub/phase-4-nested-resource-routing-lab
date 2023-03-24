class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    user = find_user
    items = Item.all
    render json: items, include: :user
  end

  def show
    user = find_user
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
    user = find_user
    item = Item.create!(item_params)
    render json: item, status: :created
  end

  private

  def find_user
    User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def render_not_found_response
    render json: { error: "Item not found" }, status: :not_found
  end

end


