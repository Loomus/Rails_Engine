class Api::V1::Invoices::RandomController < ApplicationController

  def show
    ids = Invoice.pluck(:id).shuffle
    render json: InvoiceSerializer.new(Invoice.find(ids[0]))
  end

end
