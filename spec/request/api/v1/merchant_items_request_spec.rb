require 'rails_helper'

describe 'Merchant-Items API' do
  it 'sends a list of a merchants items' do
    id = create(:merchant).id
    create_list(:item, 3, merchant_id: id)


    get "/api/v1/merchants/#{id}/items"
    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant_items = response_body[:data]

    expect(response).to be_successful
    expect(merchant_items.count).to eq(3)
  end
end
