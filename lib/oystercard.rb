class Oystercard

  attr_reader :balance
  attr_accessor :in_journey

  def initialize
    @balance = 0
    @limit = 90
    @in_journey = false
  end

  def top_up(amount)
    raise "this has exceeded the top up limit value of #{@limit}" if over_limit?(@balance, amount)
    @balance += amount
    @balance
  end

  def deduct(amount)
    @balance -= amount
    @balance
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def over_limit?(balance,amount)
    @balance + amount > @limit
  end
end