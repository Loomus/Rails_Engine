require 'rails_helper'

describe "InvoiceItem API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 100)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(100)
  end

  it "can get one item by its id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(id)
  end
end
