require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

    it 'can get one merchant by its id' do
      create_list(:merchant, 3)
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]
      # binding.pry
      expect(response).to be_successful
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:attributes)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'can find an merchant by partial name' do
    create_list(:merchant, 3)

    get '/api/v1/merchants/find?name=A'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:attributes)

    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'can find all merchants by partial name' do
    create_list(:merchant, 3)

    get '/api/v1/merchants/find_all?name=A'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response).to be_successful

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:attributes)

      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'returns empty data hash if no search data given' do
    create_list(:merchant, 3)

    get '/api/v1/merchants/find_all?name=nil'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants).to eq([])
  end

  it 'returns empty array when no match is found' do
      create_list(:merchant, 3)

      get '/api/v1/merchants/find?name=nil'

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]

      expect(response).to be_successful
      expect(merchant).to eq({})

  end
end
