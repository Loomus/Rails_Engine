class Api::V1::Invoices::SearchController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(search_params))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.find_all_by(search_params))
  end

  private

  def search_params
    params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
  end
end
