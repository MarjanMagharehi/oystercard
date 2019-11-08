class Oystercard
  attr_reader :balance
  attr_accessor :card_status
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  def initialize
    @balance = 0
    @card_status = false
  end
  def top_up(amount)
    fail "Top up failed, maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  private def deduct(amount)
    @balance -= amount
  end
  
  def journey_in?
    @card_status
  end
  def tap_in
    fail "Insufficient balance to tap in" if balance < MINIMUM_BALANCE
    @card_status = true
  end
  def tap_out
    deduct(MINIMUM_CHARGE)
    @card_status = false
  end


end
