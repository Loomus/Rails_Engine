require 'rails_helper'

describe "Invoice API" do
  it "sends a list of invoices" do
    create_list(:invoice, 100)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(100)
  end

  it "can get one item by its id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end
end
