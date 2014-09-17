##########
# runner #
##########

def runner
  welcome
  card_total = deal_two_cards
  until card_total > 21
    card_total = hit?(card_total)
  end
  end_game(card_total)
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

def welcome
  puts "Welcome to the Blackjack Table"
end

def initial_round
  first_round = deal_card + deal_card
  display_card_total(first_round)
  return first_round
end

def hit?(card_total)
  prompt_user
  user_input = get_user_input
  if user_input == "h"
    card_total += deal_card
  elsif user_input == "s"
    card_total
  else
    invalid_command
  end
end

def invalid_command
  puts "Sorry, not a valid command"
  hit?(card_total)
end

def prompt_user
  "Type 'h' to hit or 's' to stay"
end

def get_user_input
  gets.chomp.strip
end

def end_game(card_total)
  puts "Sorry"
  display_card_total(card_total)
  puts "Thanks for playing"
end
    