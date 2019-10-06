class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices

  def transactions
    Transaction.where(invoice: self.invoices).order(:id)
  end

  def self.top_bought_from(merchant)
    joins(invoices: [:transactions])
        .merge(Transaction.successful)
        .select('customers.*, COUNT(transactions.id) AS total_transactions')
        .where("invoices.merchant_id=#{merchant.id}")
        .group(:id)
        .order('total_transactions DESC')
        .first
  end
end
