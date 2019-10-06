require 'rails_helper'

describe "Invoice API" do
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
    @invoice_1 = create(:invoice, merchant: @merchant_1, customer: @customer)
    @invoice_2 = create(:invoice, merchant: @merchant_2)
    @invoice_3 = create(:invoice, merchant: @merchant_3)
    @invoice_4 = create(:invoice, merchant: @merchant_4)
    @invoice_5 = create(:invoice, merchant: @merchant_5)
    @invoice_6 = create(:invoice, merchant: @merchant_6, updated_at: DateTime.parse("2012-03-16"))
    @invoice_7 = create(:invoice, merchant: @merchant_6, updated_at: DateTime.parse("2012-03-16"))
    @transaction_1 = create(:transaction, invoice: @invoice_1, created_at: DateTime.parse("2012-03-16"))
    @transaction_2 = create(:transaction, invoice: @invoice_2, created_at: DateTime.parse("2012-03-16"))
    @transaction_3 = create(:transaction, invoice: @invoice_3, created_at: DateTime.parse("2012-03-16"))
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

  it "sends a list of invoices" do
    create_list(:invoice, 100)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(107)
  end

  it "can get one invoice by its id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice['data']["id"]).to eq(id.to_s)
  end

  it "can find one invoices by id" do
    id = create(:invoice, id: 1)

    get "/api/v1/invoices/find?id=1"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice['data']['attributes']['id']).to eq(id.id)
  end

  it "can find all invoices by status" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice)
    invoice_4 = create(:invoice)

    get '/api/v1/invoices/find_all?status=shipped'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(11)
  end

  it 'gets one invoice by searched status' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice, status: 'some status')

    get "/api/v1/invoices/find?status=some status"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice['data']['id']).to eq(invoice_3.id.to_s)
  end

  it "can get all associated transactions" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(2)
  end

  it "can get all associated Invoice Items" do
    invoice = create(:invoice)
    ii_1 = create(:invoice_item, invoice: invoice)
    ii_2 = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    iis = JSON.parse(response.body)

    expect(iis['data'].count).to eq(2)
  end

  it "gets all associated items" do
    invoice = create(:invoice)
    item_1 = create(:item)
    item_2 = create(:item)
    ii_1 = create(:invoice_item, invoice: invoice, item: item_1)
    ii_2 = create(:invoice_item, invoice: invoice, item: item_2)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(2)
  end

  it 'gets associated customer' do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers['data']['id']).to eq(customer.id.to_s)
  end

  it 'gets associated merchant' do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data']['id']).to eq(merchant.id.to_s)
  end
end
