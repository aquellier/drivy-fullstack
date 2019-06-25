require_relative '../main'
require_relative 'test_values'

describe 'Rental Price' do
  it 'should return the correct price without decrease for a one day rent' do
    expect(ONE_DAY_RENTAL.rental_price).to eq 3000
  end

  it 'should return the correct decreased_price for longer rents' do
    expect(TWO_DAYS_RENTAL.rental_price).to eq 6800
    expect(TWELVE_DAYS_RENTAL.rental_price).to eq 27_800
  end
end

describe 'Commission' do
  it 'should return the correct commission split ' do
    expect(TWO_DAYS_RENTAL.rental_price_and_commission).to eq COM_TESTED_RESULT
  end
end

describe 'Actions' do
  it 'should return the correct actions for a given rental' do
    expect(ONE_DAY_RENTAL.rental_and_actions).to eq ACTIONS_TESTED_RESULT
  end
end
