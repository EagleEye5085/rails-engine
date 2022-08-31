class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def find
    if Item.find_by_name(params[:name]) == nil
      render json: { data: {} }
    else
      render json: ItemSerializer.new(Item.find_by_name(params[:name]))
    end
  end

  def find_all
    render json: ItemSerializer.new(Item.find_all_by_name(params[:name]))
  end

  def create
    render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items.create(item_params)), status: :created
  end

  def update
    if Merchant.exists?(params[:merchant_id]) || params[:merchant_id] == nil
      Item.find(params[:id]).update(item_params)
      render json: ItemSerializer.new(Item.find(params[:id])), status: :accepted
    else
      render status: :bad_request
    end
  end

  def destroy
    render json: ItemSerializer.new(Item.find(params[:id]))
    Item.find(params[:id]).destroy
  end

  private
  def item_params
    params[:item].permit(:name, :description, :unit_price, :merchant_id)
  end
end
