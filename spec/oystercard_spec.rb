require_relative "../lib/oystercard.rb"

describe Oystercard do
    
# tests if an oyster card responds to balance
describe '#balance' do
  it 'should respond to balance' do
    expect(subject).to respond_to(:balance)
  end
end

# Testing a top up function
describe "#top_up" do
  it "should add money to the balance of the card" do
    expect { subject.top_up(50) }.to change { subject.balance }.by(50)
  end

  it "should stop top_up if we add something that breaks the limit" do
    expect { subject.top_up(100) }.to raise_error("this has exceeded the top up limit value of 90")
  end

end
end