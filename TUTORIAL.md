# Guide to Solving and Reviewing Simple Blackjack CLI

## Overview

The objective of this lab is to build a simplified version of blackjack to be played in the command line. It is simplified because the only goal is to get a card total as close to 21 as possible without going over - as long as your total is less than 21 you can choose to "hit" or "stay", as soon as you go over 21 you lose, and there is no concept of comparing your hand to the dealer's hand (and no way to win).

The command line interface will 

1. welcome the user
2. deal an initial round
3. respond to "h" (hit) and "s" stay
4. display the new card total
5. exit the game if the total goes over 21

Open `lib/blackjack.rb`. This is where all of our solution code will go. Run `rspec` to get started.

## Helper Methods

First we are going to build some methods that are responsible for doing the individual "units of work" that our game will be composed of.

### 1) `#welcome`

We want a method that will simply display a welcome message.

```ruby
def welcome
  puts "Welcome to the Blackjack Table"
end
```

This brings us to the second test.

### 2) `#deal_card`

If we run `learn`, the first failure we see is `NameError: undefined local variable or method 'deal_card'`.

We can also see the message `#deal_card generates a random number between 1-11`.

```ruby
def deal_card
end
```

The code above gets us to a different error message, but to get the test passing we need this method to return a random number between 1 and 11.

How do we generate a random number in Ruby? If you do a Google search for 'random number ruby', you'll quickly find out that Ruby comes with it's own built in random number generator method, `rand`, which takes an argument that can be an `Integer` (like `6`) or a `Range` (like `1..6`).

When you pass an integer in to `rand`, it returns a random number between 0 and the integer passed in, **not including the integer passed**. So, `rand(11)` returns a random number with a minimum value of `0` and a maximum value of `10`.

We could use `rand(11) + 1` to get us what we want, but a simpler solution is to just pass `rand` the range we want to use. Remember that you can create inclusive or exclusive ranges in Ruby, so `1..11` will include every integer from 1 to 11 including 11, while `1...11` will exclude `11`.

```ruby
def deal_card
  rand(1..11)
end
```
Now our second test passes.

### 3) `#display_card_total`

After dealing a card, our command line interface should display the card total. `#display_card_total` should take in the current total and interpolate it into a string so if the total was 5, "Your cards add up to 5" would be displayed.

```ruby
def display_card_total(card_total)
  puts "Your cards add up to #{card_total}"
end
```

This gets the third test passing.

### 4) `#prompt_user`

This method is similar to the previous one in that it only needs to return a hard-coded string that prompts the user to type 'h' for 'hit' or 's' for 'stay':

```ruby
def prompt_user
  puts "Type 'h' to hit or 's' to stay"
end
```

### 5) `#get_user_input`

```ruby
def get_user_input
  gets.chomp.strip
end
```

### 6) `#end_game`

Since there is no way to win our simplified blackjack game, `#end_game` needs to simply print an apology, card total, and thank you message:

```ruby
def end_game(card_total)
  puts "Sorry, you hit #{card_total}. Thanks for playing!"
end
```

## Methods for Playing a Single Round

Now that we have some of the basic building blocks for our blackjack game built, we can start putting things together to create methods for playing a single round.

### 7) `#initial_round`

In the initial round, two cards will be dealt and the card total will be displayed. This is where our helper methods will come in handy!

```ruby
def initial_round
  first_round = deal_card + deal_card
  display_card_total(first_round)
end
```

While the code above gets one more test passing, there is still a failure for this method:

```
Failure/Error: expect(initial_round).to eq(12)
       
       expected: 12
            got: nil
```

Why is this happening? 

Remember how return values work in Ruby - the result of the last line that executes is implicitly returned. 

The last line of our method so far is `display_card_total(first_round)`, which calls our helper method, whose last (and only) line is `puts "Your cards add up to #{whatever_was_passed_in}"`. 

What does `puts` return? `nil`!

How do we make our method return the sum of the first two cards dealt? We could _explicitly_ return it like this:

```ruby
def initial_round
  first_round = deal_card + deal_card
  display_card_total(first_round)
  
  # using the `return` keyword is how we explicitly return a value
  return first_round
end
```

However, the code above is not very ruby-esque. Because of Ruby's implicit returns, we just can just call `first_round` on the last line without the `return` keyword.

```ruby
def initial_round
  first_round = deal_card + deal_card
  display_card_total(first_round)
  
  # whatever is on the last line gets implicitly returned
  first_round
end
```

### 8) `#hit?`

The next method will have a good deal of logic to it, so let's approach it step by step. According to the spec, this is the functionality of the method:

1. calls on `#prompt_user` then `#get_user_input`
2. deals another card when user types 'h'
3. does not deal another card if user types 's'
4. returns an integer which is the card total

```ruby
def hit?(card_total)
  # part 1
  prompt_user
  user_input = get_user_input
  
  # parts 2, 3, and 4
  if user_input == "h"
    # this is the last line that will execute if the user types 'h', both dealing another card and returning the card total
    card_total += deal_card
  elsif user_input == "s"
    # this is the last line that will execute if the user types 's', simply returning the card total without dealing another card
    card_total
  end
end
```

This gets all of our tests for `#hit` passing, but it seems like something is not being accounted for - what if the user enters something other than 'h' or 's'? Let's go ahead and account for that.

### 9) `#invalid_command` (bonus method)

What should happen if the user types something other than 'h' or 's'?

1. They should see a message explaining that their input was invalid.
2. They should be prompted again to enter something valid.

Let's make a method that does exactly that:

```ruby
def invalid_command
  puts "Sorry, not a valid command"
  
  # again, here's one of our handy helper methods!
  get_user_input
end
```

Now, where in the course of our gameplay do we want this method to fire? Right now, the `hit?` method is responsible for dealing with input that's either 'h' or 's', so it looks like that's where we should account for invalid commands.

A simple `else` statement will do the trick:

```ruby
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
```

## Putting It All Together

The `#runner` method is responsible for allowing the user to play an entire game of blackjack. It should:

1. welcome the user
2. deal the initial round and save the total so we can pass it to the `hit?` method
3. call the `hit?` method and display the new card total over and over until the card total exceeds 21
4. end the game

Since we already wrote methods for doing all the individual units of work that we need, all we need to do is compose it using the correct order and logic.

```ruby
def runner
  welcome
  card_total = initial_round
  until card_total > 21
    card_total = hit?(card_total)
    display_card_total(card_total)
  end
  end_game(card_total)
end
```

And that's the whole game!

## Bonus

1. Make it so users can play as many games as they want in one sitting (without running the program again).
2. Allow users to play against the computer (or another user), and make it possible to win!
