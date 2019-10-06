require 'rails_helper'

describe "Item API" do
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

  it "gets a list of items" do
    create_list(:item, 100)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(106)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']["id"]).to eq(id.to_s)
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

  it "can find one item by created at" do
    created_at = create(:item).created_at

    get "/api/v1/items/find?created_at=#{created_at}"

    expect(response).to be_successful
  end

  it "can find one item by unit price" do
    unit_price = create(:item).unit_price

    get "/api/v1/items/find?unit_price=#{unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['unit_price']).to eq(unit_price.to_f.to_s)
  end

  it "can find one item by description" do
    description = create(:item).description

    get "/api/v1/items/find?description=#{description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['description']).to eq(description)
  end

  it "can find all items by created_at" do
    created = Time.now + 3000
    item_1 = create(:item)
    item_2 = create(:item, created_at: created)
    item_3 = create(:item, created_at: created)

    get "/api/v1/items/find_all?created_at=#{created}"

    expect(response).to be_successful
  end

  it "can find one item by merchant id" do
    merchant_id = create(:item).merchant_id
    # binding.pry
    get "/api/v1/items/find?merchant_id=#{merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)
    # binding.pry
    expect(item['data']['attributes']['merchant_id']).to eq(merchant_id)
  end

  it "can find all items by merchant_id" do
    merchant = create(:merchant)
    item_1 = create(:item)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['id']).to eq(item_2.id.to_s)
    expect(items['data'].last['id']).to eq(item_3.id.to_s)
  end

  it "can find all items by name" do
    item_1 = create(:item)
    item_2 = create(:item, name: 'Sam')
    item_3 = create(:item, name: 'Sam')

    get "/api/v1/items/find_all?name=Sam"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['attributes']['name']).to eq('Sam')
    expect(items['data'].last['attributes']['name']).to eq('Sam')
  end

  it "can find all items by price" do
    price = 55.99
    item_1 = create(:item, unit_price: price)
    item_2 = create(:item, unit_price: price)
    item_3 = create(:item)

    get "/api/v1/items/find_all?unit_price=#{price}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['id']).to eq(item_1.id.to_s)
    expect(items['data'].last['id']).to eq(item_2.id.to_s)
  end

  it "can find all items by description" do
    description = 'this is an item'
    item_1 = create(:item, description: description)
    item_2 = create(:item, description: description)
    item_3 = create(:item)

    get "/api/v1/items/find_all?description=#{description}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['id']).to eq(item_1.id.to_s)
    expect(items['data'].last['id']).to eq(item_2.id.to_s)
  end

  it "can find a random item" do
    create_list(:item, 3)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    id = item['data']['attributes']['id']
    expect(Item.find(id)).to be_instance_of(Item)
  end

  it "can find associated invoice items" do
    item = create(:item)
    invoice_item_1 = create(:invoice_item, item: item)
    invoice_item_2 = create(:invoice_item, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].first['id']).to eq(invoice_item_1.id.to_s)
  end
end
