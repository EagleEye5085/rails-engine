require 'rails_helper'

RSpec.describe 'merchant model' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Billy')
    @merchant2 = Merchant.create!(name: 'Thomas')
    @merchant3 = Merchant.create!(name: 'Tyler')
  end

  it 'can find a merchant by pertial name' do
    expect(Merchant.find_by_name('th')[:name]).to eq('Thomas')
  end

  it 'can find all merchants by pertial name' do
    expect(Merchant.find_all_by_name('y').count).to eq(2)
    expect(Merchant.find_all_by_name('y').count).to_not eq(3)
  end
end
