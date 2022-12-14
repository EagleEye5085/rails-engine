require 'rails_helper'

RSpec.describe 'items api requests' do
  it 'sends a list of items' do
    merchant_id = create(:merchant).id
    create_list(:item, 3, merchant_id: merchant_id)
    get '/api/v1/items'

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:attributes)

      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'can get one item by its id' do
    merchant_id = create(:merchant).id
    create_list(:item, 3, merchant_id: merchant_id)
    id = create(:item, merchant_id: merchant_id).id

    get "/api/v1/items/#{id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(item).to have_key(:id)
    expect(item).to have_key(:attributes)

    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'can create an item' do
    create_list(:merchant, 1)
    get '/api/v1/items'

    item_params = ({
                name: 'Super Big Big Mac',
                description: 'Burger',
                unit_price: '50.0',
                merchant_id: Merchant.first.id
              })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price.to_s).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an item' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id

    item_params = { name: "Book" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params, merchant_id: merchant_id)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item[:name]).to eq("Cell Phone")
  end

  it 'return 400 if unable to update an item' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id

    item_params = { name: "Book" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params, merchant_id: 500)
    item = Item.find_by(id: id)

    expect(response.status).to eq(400)

  end

  it 'can delete an item' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can find an item by partial name' do
    merchant_id = create(:merchant).id
    create_list(:item, 3, merchant_id: merchant_id)

    get '/api/v1/items/find?name=A'

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item).to have_key(:attributes)

    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)

  end

  it 'returns empty array when no match is found' do
      merchant_id = create(:merchant).id
      create_list(:item, 3, merchant_id: merchant_id)

      get '/api/v1/items/find?name=nil'

      response_body = JSON.parse(response.body, symbolize_names: true)
      item = response_body[:data]

      expect(response).to be_successful
      expect(item).to eq({})

    end

  it 'can find all items by partial name' do
    merchant_id = create(:merchant).id
    create_list(:item, 3, merchant_id: merchant_id)

    get '/api/v1/items/find_all?name=A'

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:attributes)

      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'returns empty array when no match is found' do
      merchant_id = create(:merchant).id
      create_list(:item, 3, merchant_id: merchant_id)

      get '/api/v1/items/find_all?name=nil'

      response_body = JSON.parse(response.body, symbolize_names: true)
      item = response_body[:data]

      expect(response).to be_successful
      expect(item).to eq([])

    end

end
