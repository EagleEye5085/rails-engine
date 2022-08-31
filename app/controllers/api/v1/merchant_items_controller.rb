class Api::V1::MerchantItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).all_items)
  end

  def show
    render json: ItemSerializer.new(Merchant.find(params[:id]))
  end
end
