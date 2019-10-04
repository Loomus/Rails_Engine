require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 100)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(100)
  end

  it "can get one item by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it "can find one merchant by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['name']).to eq(name)
  end

  it "can find all merchants by name" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant, name: 'Meriadoc')
    merchant_4 = create(:merchant, name: 'Meriadoc')

    get '/api/v1/merchants/find_all?name=Meriadoc'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    # binding.pry
    expect(merchants['data'].count).to eq(2)
  end
end
