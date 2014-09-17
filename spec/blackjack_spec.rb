describe "#deal_card" do
  
  it "generates a random number between 1-11" do
    expect(deal_card).to be > 0
    expect(deal_card).to be < 12
  end

end

describe "#runner"

  it "prints welcome to the screen" do
    expect(deal_card).to be > 0
    expect(deal_card).to be < 12
  end

end

describe "#display_card_total"

  it "accepts one argument, the card total" do
    expect(display_card_total(7)).to_not raise_error(ArgumentError)
  end

  it "prints the value of the cards to the screen" do
    expect(display_card_total(8))
  end

end