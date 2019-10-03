class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
   render json: InvoiceItemSerializer.new(InvoiceItem.find_by(search_params))
  end

  private

  def search_params
    params.permit(:id, :quantity, :unit_price, :invoice_id, :item_id, :created_at, :updated_at)
  end
end
