class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.best_for(customer)
    joins(invoices: :transactions)
        .where("invoices.customer_id=#{customer.id}")
        .merge(Transaction.successful)
        .select('merchants.*, count(transactions.id) AS transaction_count')
        .group(:id)
        .order('transaction_count DESC')
        .first
  end
end
