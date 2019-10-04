class Api::V1::Merchants::RandomController < ApplicationController

  def show
    ids = Merchant.pluck(:id).shuffle
    render json: MerchantSerializer.new(Merchant.find(ids[0]))
  end

end
