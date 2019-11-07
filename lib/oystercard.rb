class Oystercard
  attr_reader :balance
  attr_accessor :card_status
  MAXIMUM_BALANCE = 90
  def initialize
    @balance = 0
    @card_status = false
  end
  def top_up(amount)
    fail "Top up failed, maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end
  def deduct(amount)
    @balance -= amount
  end
  def journey_in?
    @card_status
  end
  def tap_in
    @card_status = true
  end
  def tap_out
    @card_status = false
  end
end
