class Api::V1::Transactions::SearchController < ApplicationController

  def show
    render json: TransactionSerializer.new(Transaction.find_by(search_params))
  end

  def index
    render json: TransactionSerializer.new(Transaction.find_all_by(search_params))
  end

  private

  def search_params
    params.permit(:id, :credit_card_expiration_date, :credit_card_number, :result, :invoice_id, :created_at, :updated_at)
  end
end
