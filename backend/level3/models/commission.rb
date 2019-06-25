# Commission model, belongs to rental
class Commission
  attr_reader :rental, :insurance_fee, :assistance_fee, :drivy_fee

  def initialize(rental)
    @rental = rental
  end

  def commission_split
    total_com = (@rental.rental_price * 3) / 10
    @insurance_fee = (total_com * 5) / 10
    @assistance_fee = @rental.rental_days * 100
    @drivy_fee = total_com - (@insurance_fee + @assistance_fee)
    {
      insurance_fee: @insurance_fee,
      assistance_fee: @assistance_fee,
      drivy_fee: @drivy_fee
    }
  end
end
