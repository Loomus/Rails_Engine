class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    ids = InvoiceItem.pluck(:id).shuffle
    render json: InvoiceItemSerializer.new(InvoiceItem.find(ids[0]))
  end

end
