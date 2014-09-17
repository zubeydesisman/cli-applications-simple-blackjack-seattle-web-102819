##########
# runner #
##########

def runner
  welcome
  card_total = deal_two_cards
  until card_total > 21
    hit?(card_total)
  end
  lost(card_total)
end

##################
# shared methods #
##################

def display_card_total(card_total)
  puts "Your cards add up to #{card_total}"
end

def deal_card
  rand(1..11)
end

##########
# rounds #
##########

# pre-round 1
def welcome
  puts "Welcome to the Blackjack Table"
end

# round 1
def deal_two_cards
  first_round = deal_card + deal_card
  display_card_total(first_round)
  return first_round
end

# rounds 2 - ∞
def hit?(card_total)
  "Type 'h' to hit or 's' to stay"
  user_input = gets.chomp.strip
  if user_input == "h"

  elsif user_input == "s"

  else
    puts "Sorry, not a valid command"
    hit?(card_total)
  end
end

#######
# end #
#######

def lost(card_total)
  display_card_total(card_total)
  puts "Sorry, you've lost."
end
    