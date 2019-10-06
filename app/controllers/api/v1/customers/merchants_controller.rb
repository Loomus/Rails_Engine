class Api::V1::Customers::MerchantsController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.best_for(Customer.find(params[:customer_id])))
  end

end
