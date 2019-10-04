class Api::V1::Customers::RandomController < ApplicationController

  def show
    ids = Customer.pluck(:id).shuffle
    render json: CustomerSerializer.new(Customer.find(ids[0]))
  end

end
