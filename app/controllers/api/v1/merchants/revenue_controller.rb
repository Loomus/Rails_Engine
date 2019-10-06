class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    limit = params[:quantity]
    render json: MerchantSerializer.new(Merchant.top_by_revenue(limit))
  end
end
