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
    expect(subject.top_up(50)).to eq 50
end
end
end