# Simplified Blackjack - Procedural

## Background - Objectives

In [Blackjack](http://en.wikipedia.org/wiki/Blackjack) the goal is to have a hand that is closer to 21 than the dealer's hand without ever exceeding a card total of 21. 

However, in this simplified version of Blackjack, we'll cut out that "compare with the dealer's hand" part and pretend that the goal of the game is to have a card total of, or very close to, but never exceeding, 21.

To start, a player gets dealt two cards, each of which have values between 1-11. If they happened to get unlucky and have a sum of 22 (two 11-value cards), then they lose. Otherwise, they can decide to hit or to stay.

If they hit, they get dealt another card. If the sum of their three cards exceeds 21, they've lost. If it does not, they can decide to hit or stay again FOREVER.

If you're thinking, "But now there's no way to win!", then you'd be right. In this simple, simple version of Blackjack, there is no way to win. Once you've completed this lab, feel free to make a second version where there IS a way to win. Maybe even include the real rules and compare the user's hand to the dealer's hand.

## Objective

Practice conditional logic and loops by making a command line game that plays blackjack. 

# Instructions

All your code will go in `lib/blackjack.rb`. This lab is test driven so just run `rspec` to get started.

Once every test is working, run  `ruby lib/runner.rb` from the root directory to play!

## Resources
* [Wikipedia](http://en.wikipedia.org/) - [Blackjack](http://en.wikipedia.org/wiki/Blackjack)
