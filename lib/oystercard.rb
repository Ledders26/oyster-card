class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
    @limit = 90
  end

  def top_up(amount)
    raise "this has exceeded the top up limit value of #{@limit}" if over_limit?(@balance, amount)
    @balance += amount
    @balance
  end

  private

  def over_limit?(balance,amount)
    @balance + amount > @limit
  end
end