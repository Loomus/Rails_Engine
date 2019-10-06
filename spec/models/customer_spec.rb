require 'rails_helper'

describe Customer do
  describe "validations" do
    it { should validate_presence_of :last_name}
    it { should validate_presence_of :first_name}
  end

  describe "relationships" do
    it { should have_many :invoices }
  end

  describe 'class methods' do
    before :each do
      @merchant_1 = create(:merchant, name: "Merch1")
      @merchant_2 = create(:merchant, name: "Merch2")
      @merchant_3 = create(:merchant, name: "Merch3")
      @merchant_4 = create(:merchant, name: "Merch4")
      @merchant_5 = create(:merchant, name: "Merch5")
      @merchant_6 = create(:merchant, name: "Merch6")
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_2)
      @item_3 = create(:item, merchant: @merchant_3)
      @item_4 = create(:item, merchant: @merchant_4)
      @item_5 = create(:item, merchant: @merchant_5)
      @item_6 = create(:item, merchant: @merchant_6)
      @customer = create(:customer)
      @invoice_1 = create(:invoice, merchant: @merchant_1, updated_at: "2012-03-16 13:54:11 UTC")
      @invoice_2 = create(:invoice, merchant: @merchant_2, updated_at: "2012-03-16 13:54:11 UTC")
      @invoice_3 = create(:invoice, merchant: @merchant_3, updated_at: "2012-03-16 13:54:11 UTC")
      @invoice_4 = create(:invoice, merchant: @merchant_4)
      @invoice_5 = create(:invoice, merchant: @merchant_5)
      @invoice_6 = create(:invoice, merchant: @merchant_6, updated_at: "2012-03-16 13:54:11 UTC", customer: @customer)
      @invoice_7 = create(:invoice, merchant: @merchant_6, updated_at: "2012-03-16 13:54:11 UTC", customer: @customer)
      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:transaction, invoice: @invoice_3)
      @transaction_4 = create(:transaction, invoice: @invoice_4)
      @transaction_5 = create(:transaction, invoice: @invoice_5)
      @transaction_6 = create(:transaction, invoice: @invoice_6)
      @transaction_7 = create(:transaction, invoice: @invoice_7, result: 'failed')
      @ii_1 = InvoiceItem.create(quantity: 1, item: @item_1, unit_price: 1.0, invoice: @invoice_1)
      @ii_2 = InvoiceItem.create(quantity: 2, item: @item_2, unit_price: 2.0, invoice: @invoice_2)
      @ii_3 = InvoiceItem.create(quantity: 3, item: @item_3, unit_price: 3.0, invoice: @invoice_3)
      @ii_4 = InvoiceItem.create(quantity: 4, item: @item_4, unit_price: 4.0, invoice: @invoice_4)
      @ii_5 = InvoiceItem.create(quantity: 5, item: @item_5, unit_price: 5.0, invoice: @invoice_5)
      @ii_6 = InvoiceItem.create(quantity: 6, item: @item_6, unit_price: 6.0, invoice: @invoice_6)
      @ii_7 = InvoiceItem.create(quantity: 7, item: @item_6, unit_price: 7.0, invoice: @invoice_7)
    end

    it "#top_customer" do
      top_customer = Customer.top_bought_from(@merchant_6)

      expect(top_customer).to eq(@customer)
    end

    it ".find_all_by" do
      customer = create(:customer)
      params = {id: customer.id}

      customers = Customer.find_all_by(params)

      expect(customers.first).to eq(customer)
    end

  end

  describe 'instance methods' do

    it "#transactions" do
      customer = create(:customer)
      invoice_1 = create(:invoice, customer: customer)
      invoice_2 = create(:invoice, customer: customer)
      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)
      create(:transaction)

      transactions = customer.transactions

      transactions.each do |transaction|
        expect(transaction).to be_instance_of(Transaction)
      end

      expect(transactions.count).to eq(2)
    end

  end
end
