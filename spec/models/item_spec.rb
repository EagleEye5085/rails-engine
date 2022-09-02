require 'rails_helper'

RSpec.describe 'item model' do
  before :each do
    @merchant = Merchant.create!(name: 'Thomas')

    @item1 = @merchant.items.create!(name: 'Toy', description: 'its a toy', unit_price: 12.0)
    @item2 = @merchant.items.create!(name: 'chair', description: 'its a chair', unit_price: 10.0)
    @item3 = @merchant.items.create!(name: 'Phone', description: 'its a phone', unit_price: 120.0)
  end

  it 'can find an item by pertial name' do
    expect(Item.find_by_name('to')[:name]).to eq('Toy')
  end

  it 'can find all items by pertial name' do
    expect(Item.find_all_by_name('o').count).to eq(2)
    expect(Item.find_all_by_name('o').count).to_not eq(3)
  end
end
