class Api::V1::Merchants::TotalRevenueController < ApplicationController
  def show
      render json: TotalRevenueSerializer.new(Merchant.find(params[:merchant_id]).total_revenue_by_date(params[:date]))
  end
end
