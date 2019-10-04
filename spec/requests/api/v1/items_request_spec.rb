require 'rails_helper'

describe "Item API" do
  it "sends a list of items" do
    create_list(:item, 100)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(100)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can find one item by name" do
    name = create(:item).name

    get "/api/v1/items/find?name=#{name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['name']).to eq(name)
  end

  it "can find all items by updated_at" do
    updated = Time.now

    item_1 = create(:item)
    item_2 = create(:item, updated_at: updated)
    item_3 = create(:item, updated_at: updated)

    get "/api/v1/items/find_all?updated_at=#{updated}"

    expect(response).to be_successful
  end

  it "can find a random item" do
    create_list(:item, 3)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    id = item['data']['attributes']['id']
    expect(Item.find(id)).to be_instance_of(Item)
  end
end
