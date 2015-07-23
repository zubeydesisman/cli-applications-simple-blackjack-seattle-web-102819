# Simplified Blackjack - Procedural

## Objective

1. Utilize conditional logic and looping
2. Gain an introduction to the command line interface

## Background

In [Blackjack](http://en.wikipedia.org/wiki/Blackjack) the goal is to have a hand that is closer to 21 than the dealer's hand without ever exceeding a card total of 21. 

However, in this simplified version of Blackjack, we'll cut out that "compare with the dealer's hand" part and pretend that the goal of the game is to have a card total of, or very close to, but never exceeding, 21.

To start, a player gets dealt two cards, each of which have values between 1-10. Then, the player is asked if they want to "hit" (get another card dealt to them), or "stay".

If they hit, they get dealt another card. If the sum of their three cards exceeds 21, they've lost. If it does not, they can decide to hit or stay again FOREVER.

If you're thinking, "But now there's no way to win!", then you'd be right. In this simple, simple version of Blackjack, there is no way to win. Once you've completed this lab, feel free to make a second version where there IS a way to win. Maybe even include the real rules and compare the user's hand to the dealer's hand.

## The Command Line Interface

**A Brief Note:** This is a brief introduction to command line apps. It's okay if you don't understand everything we discuss here. We're going to take a more in depth look in your next command line application.


The CLI, or command line interface, is the interaction between a user and their computer or a program via the command line. You've already become comfortable interacting with the command line to navigate files and connect with Github and test your programs. In a command line application, the user will respond to a prompt that your program will output to the terminal. The user's response, or input, will be received by the application and the application will then carry out the programmed response based on that input.

In fact, you've already played around with a command line app in one of the previous lessons––Looping: Break and Gets. When you executed the `annoying_program` file, the `puts` method output some text to the terminal and the `gets` method collected and saved the user's input to the terminal. We'll be using the same techniques to build our simple blackjack game. 

### How does `puts` output text to the terminal?

Here's a brief reminder from an earlier lesson––Puts, Print and Return (from the Methods and Variables unit). 

>
How do the puts and print methods actually output text to your console? They use the $stdout global variable provided to us by Ruby. You don't need to worry about global variables right now. For the purposes of understanding how puts and print work, we just need to understand the following:

>Your computer has an stdout file that communicates with your operating system. So, puts and print actually send output to the $stdout variable. The $stdout variable sends that information to the stdout file on your computer which in turn communicates with your operating system which in turn outputs that information to the console.

You can absolutely employ puts and print without understanding everything that was just described. But now you have a basic sense of what is happening under the hood of these methods.
 -what is a command line app? include idea of bin/runner file. 
-how do puts and gets allow a user to interact with the program?
-how will our test suite fake it?

### Running our Command Line App

We already know that we can run, or execute the code in, a Ruby file from the command line by typing `ruby <file name>`. In a command line app, it is conventional to create a special file that has one responsibility: executing the code that constitutes our program. You can think about this in terms of the separation of concerns principle. The separation of concerns principle is a programming design principle for separating the responsibilities and functionalities into discreet sections. For our command line app, that means that we have one file that defines the methods we will use to play our blackjack game and a *separate* file that calls those methods. Then, we will play our game by executing the that "runner" file via `ruby runner.rb` in the command line. 

### Testing our Command Line App

You already know that your Blackjack command line app will rely on the user's input to run. In order to test our program using RSpec, we need a way for our test suite to fake the user's input, i.e. fake the implementation of the `puts` and `gets` methods. This is called **stubbing**. 

#### What is Stubbing?

Stubbing refers to the fake implementation of a method. In this case, we will stub the `puts` method to trick our test suite into thinking the stdout file has received the `puts` method *and* to trick our test suite into recognizing that the `gets` method has been used. 

In the next command line app that you will build, we will discuss stubbing in much greater detail. For now, just understand the following about how to read our test suite: 

**First:** 

```ruby
expect($stdout).to receive(:puts).with("Type 'h' to hit or 's' to stay")
```
The above line means that the test suite is expecting the execution of a certain method to use the `puts` method to output "Type 'h' to hit or 's' to stay". 

**Second:**

```ruby
expect(self).to receive(:get_user_input).and_return("s")
```

The above line means that the test suite is expecting the execution of a certain method to use the `gets` method to store the user's input and return that input (which in this particular test happens to be "s"). 




## Instructions

All your code will go in `lib/blackjack.rb`. 

Once every test is working, run  `ruby lib/runner.rb` from the root directory to play!

### Using TDD

This lab is test driven, so run `learn` or `rspec` to guide you through the program. We're not providing step-by-step instructions for this one, purposefully. The concept of Test-Driven Development, or TDD, is that the desired behavior of our program is what guides our development. So, we've provided extensive tests here that are designed to tell you how each method should behave. 

**Read the test output very carefully!** Pay attention to whether or not the test is telling you that the method should be defined to take in an argument. Pay attention to what the test expects the return value of the method to be. 

We're going to take a look at one example together, and for the rest of the methods, you'll be required to let the tests guide you. 

In the test suite, we have the following test: 

```ruby
describe "#display_card_total" do
  it "accepts one argument, the card total" do
    expect { display_card_total(7) }.to_not raise_error
  end
  
  it "prints the value of the cards to the screen" do
    expect($stdout).to receive(:puts).with("Your cards add up to 8")
    display_card_total(8)
  end
  ....
```

This test is telling us the following things about the method called `display_card_total`:

*  The method should take in an argument of a number that is the card total. 
*  The method should use `puts` to output that card total as part of the phrase `"Your cards add up to #{card total}"`.

#### A Note on Calling Methods Within Methods:

Remember that you can call methods within methods. In other words, if you define a method, `deal_card`, that deals a card to the user, then that method is available to be called in any other methods––such as your `hit` method which should deal a card to the user *if* they input "h" for "hit" upon being prompted. 

### Using Looping: Defining the the game play via the `run` method

Once you get all of the tests in the first part of the test suite passing, you've build the building blocks of our blackjack game. Now, we need to put them all together in the `run` method. The `run` method is responsible for enacting the game play *until* the user looses. Remember that a player looses if the sum of their cards exceeds 21. 

Here's how we want our game to run: 

1. Welcome the user
2. Deal them their first two cards, i.e. their `initial_turn`
3. Ask them if they want to hit or stay
4. If they want to hit, deal another card
5. If they want to stay, ask them again!
6. If their card total exceeds 21, the game ends. 

Use a loop constructor (I'd recommend `until`, but that is by no means your only option) to enact the above game play in the `run` method. Then, check out the `lib/runner.rb` file. Notice that it is simply calling the `run` method. The runner file will call the `run` method which should in turn utilize all the other methods you built!



  

## Resources
* [Wikipedia](http://en.wikipedia.org/) - [Blackjack](http://en.wikipedia.org/wiki/Blackjack)
