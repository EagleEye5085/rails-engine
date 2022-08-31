require 'rails_helper'

describe 'Item-Merchant API' do
  it 'find a merchant by item' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id

    get "/api/v1/items/#{id}/merchant"
    response_body = JSON.parse(response.body, symbolize_names: true)
    item_merchant = response_body[:data]
    expect(response).to be_successful
    expect(item_merchant[:attributes][:name]).to eq("Ezequiel Weber Jr.")
  end
end
