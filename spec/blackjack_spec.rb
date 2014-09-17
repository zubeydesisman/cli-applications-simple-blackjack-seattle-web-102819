describe "#deal_card" do
  it "generates a random number between 1-11" do
    20.times do 
      card = deal_card
      expect(card).to be > 0
      expect(card).to be < 12
    end
  end
end

describe "#display_card_total" do
  it "accepts one argument, the card total" do
    expect { display_card_total(7) }.to_not raise_error
  end

  it "prints the value of the cards to the screen" do
    expect($stdout).to receive(:puts).with("Your cards add up to 8")
    display_card_total(8)
  end

  it "does not hardcode the card total" do
    expect($stdout).to receive(:puts).with("Your cards add up to 12")
    display_card_total(12)
  end
end

describe "#welcome" do
  it "prints a welcome message to screen" do
    expect($stdout).to receive(:puts).with("Welcome to the Blackjack Table")
    welcome
  end
end

describe "#initial_round" do
  it "calls on the '#display_card_total' to print sum of cards" do
    expect($stdout).to receive(:puts).with(/Your cards add up to /)
    initial_round
  end

  it "returns the sum of two cards added togther" do
    20.times do
      two_cards = initial_round
      expect(two_cards).to be > 1
      expect(two_cards).to be < 23
    end
  end
end

describe "#end_game" do
  it "prints apology, card total, and thank you message" do
    expect($stdout).to receive(:puts).with("Sorry, you hit 27. Thanks for playing!")
    end_game(27)
  end
end

describe "#prompt_user" do
  it "gives instructions for hitting or staying" do
    expect($stdout).to receive(:puts).with("Type 'h' to hit or 's' to stay")
    prompt_user
  end
end

describe "#get_user_input" do
  it "returns the value of a `gets.chomp` method" do
    ["h", "s", "exit"].each do |string|
      with_stdin do |user|
        user.puts string
        expect(get_user_input).to eq(string)
      end
    end
  end
end

describe "#hit?" do
  before(:each) do
    def get_user_input
      "s"
    end
  end
  it "calls on the '#prompt_user' method" do
    expect($stdout).to receive(:puts).with("Type 'h' to hit or 's' to stay")
    hit?(7)
  end

  it "returns an integer which is the card total" do
    expect(hit?(20)).to eq(20)
  end

  it "calls on the '#get_user_input' and does not deal another card if user types 's'" do
    expect(hit?(7)).to eq(7)
  end

  it "calls on the '#get_user_input' and deals another card when user types 'h'" do
    def get_user_input
      "h"
    end
    expect(hit?(7)).to be > 7
  end
end

describe "#runner" do

end
