require 'rails_helper'

describe "Transaction API" do
  it "sends a list of transactions" do
    create_list(:transaction, 100)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(100)
  end

  it "can get one item by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["id"]).to eq(id)
  end

  it "can find one transaction by credit card number" do
    transaction_2 = create(:transaction, credit_card_number: 9876)

    get "/api/v1/transactions/find?credit_card_number=9876"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction['data']['id']).to eq(transaction_2.id.to_s)
  end

  it "can find all transactions by result" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)
    transaction_3 = create(:transaction)
    transaction_4 = create(:transaction)
    transaction_5 = create(:transaction, result: 'failed')

    get "/api/v1/transactions/find_all?result=success"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(4)
  end
end
