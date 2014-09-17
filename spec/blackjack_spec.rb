describe "#blackjack" do
  
  it "generates a random number between 1-11" do
    expect(deal_card).to be > 0
    expect(deal_card).to be < 12
  end
  
end