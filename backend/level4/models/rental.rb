require 'date'
require_relative 'commission'
# Rental model, belongs to car
class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance
  STAKEHOLDERS = %w[driver owner insurance assistance drivy].freeze

  def initialize(id, car, start_date, end_date, distance)
    @id = id
    @car = car
    @start_date = Date.strptime(start_date, '%Y-%m-%d')
    @end_date = Date.strptime(end_date, '%Y-%m-%d')
    @distance = distance
    @commission = Commission.new(self)
  end

  def rental_days
    (@end_date - @start_date).to_i + 1
  end

  def rental_price
    day_decrease(rental_days, @car.price_per_day) +
      @distance * @car.price_per_km
  end

  def rental_price_and_commission
    { id: @id, price: rental_price, commission: @commission.commission_split }
  end

  def rental_and_actions
    { id: @id, actions: actions }
  end

  private

  def day_decrease(nb_of_days, price_per_day)
    decreased_price = 0
    nb_of_days.times do |day|
      decreased_price += case day
                         when 0 then price_per_day
                         when 1..3 then (price_per_day * 9) / 10
                         when 4..9 then (price_per_day * 7) / 10
                         else (price_per_day * 5) / 10
                         end
    end
    decreased_price
  end

  def actions
    actions = []
    STAKEHOLDERS.each do |stakeholder|
      type = stakeholder == 'driver' ? 'debit' : 'credit'
      actions << { who: stakeholder,
                   type: type,
                   amount: action_amount(stakeholder) }
    end
    actions
  end

  def action_amount(stakeholder)
    case stakeholder
    when 'driver' then rental_price
    when 'owner' then rental_price - @commission.total_commission
    when 'insurance' then @commission.insurance_fee
    when 'assistance' then @commission.assistance_fee
    else @commission.drivy_fee
    end
  end
end
