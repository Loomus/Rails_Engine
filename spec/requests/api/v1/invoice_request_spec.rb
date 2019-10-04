require 'rails_helper'

describe "Invoice API" do
  it "sends a list of invoices" do
    create_list(:invoice, 100)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(100)
  end

  it "can get one invoice by its id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
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

    expect(invoices['data'].count).to eq(4)
  end
end
