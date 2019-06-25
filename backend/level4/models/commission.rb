# Commission model, belongs to rental
class Commission
  attr_reader :rental

  def initialize(rental)
    @rental = rental
  end

  def total_commission
    (@rental.rental_price * 3) / 10
  end

  def insurance_fee
    (total_commission * 5) / 10
  end

  def assistance_fee
    @rental.rental_days * 100
  end

  def drivy_fee
    total_commission - (insurance_fee + assistance_fee)
  end

  def commission_split
    {
      insurance_fee: insurance_fee,
      assistance_fee: assistance_fee,
      drivy_fee: drivy_fee
    }
  end
end
