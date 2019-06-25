require_relative '../main'

describe 'Rental Price' do
  it 'should return the correct price without decrease for a one day rent' do
    car = Car.new(1, 2000, 10)
    rental = Rental.new(1, car, '2015-12-8', '2015-12-8', 100)
    expect(rental.rental_price).to eq 3000
  end

  it 'should return the correct decreased_price for longer rents' do
    car = Car.new(1, 2000, 10)
    two_days_rental = Rental.new(1, car, '2015-03-31', '2015-04-01', 300)
    twelve_days_rental = Rental.new(1, car, '2015-07-03', '2015-07-14', 1000)

    expect(two_days_rental.rental_price).to eq 6800
    expect(twelve_days_rental.rental_price).to eq 27_800
  end
end

describe 'Commision' do
  it 'should return the correct commission split ' do
    car = Car.new(1, 2000, 10)
    two_days_rental = Rental.new(1, car, '2015-03-31', '2015-04-01', 300)

    com_tested_result = {
      id: 1,
      price: 6800,
      commission: {
        insurance_fee: 1020,
        assistance_fee: 200,
        drivy_fee: 820
      }
    }
    expect(two_days_rental.rental_price_and_commission).to eq com_tested_result
  end
end
