require 'rails_helper'

describe "Customer API" do
  it "sends a list of customers" do
    create_list(:customer, 100)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(100)
  end

  it "can get one item by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  it "can find one customer by first name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)
    
    expect(customer['data']['attributes']['first_name']).to eq(first_name)
  end
end
