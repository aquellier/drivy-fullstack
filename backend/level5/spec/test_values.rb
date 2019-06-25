require_relative '../main'

CAR = Car.new(1, 2000, 10)
ONE_DAY_RENTAL = Rental.new(1, CAR, '2015-12-8', '2015-12-8', 100)
TWO_DAYS_RENTAL = Rental.new(1, CAR, '2015-03-31', '2015-04-01', 300)
TWELVE_DAYS_RENTAL = Rental.new(1, CAR, '2015-07-03', '2015-07-14', 1000)
COM_TESTED_RESULT = {
  id: 1,
  price: 6800,
  commission: {
    insurance_fee: 1020,
    assistance_fee: 200,
    drivy_fee: 820
  }
}.freeze
ACTIONS_TESTED_RESULT = {
  id: 1,
  actions: [
    {
      who: 'driver',
      type: 'debit',
      amount: 3000
    },
    {
      who: 'owner',
      type: 'credit',
      amount: 2100
    },
    {
      who: 'insurance',
      type: 'credit',
      amount: 450
    },
    {
      who: 'assistance',
      type: 'credit',
      amount: 100
    },
    {
      who: 'drivy',
      type: 'credit',
      amount: 350
    }
  ]
}.freeze
