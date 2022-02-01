# frozen_string_literal: true

# Create instances of Oyster Card
class Oystercard
  CARD_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance
  attr_accessor :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "this has exceeded the top up limit value of #{CARD_LIMIT}" if over_limit?(amount)
    @balance += amount
  end

  def touch_in
    raise 'Insufficient balance' if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def over_limit?(amount)
    @balance + amount > CARD_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
