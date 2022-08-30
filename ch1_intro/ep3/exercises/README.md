# Challenge questions

1. Create a Python file (or a notebook) to hold your code for these exercises.

1. Prompt the user for an integer
    1. If the input is not an integer, give the user a warning and prompt them again
    1. Calculate the sum of all the integers from 1 to n (the number the user entered)
    1. For each number, output whether that number is even or odd

1. Write a function, `func2()`, that will accept two numbers as input and return BOTH the sum and difference of the two numbers. Hint: use a tuple as your return type.

<br/><br/>

## A Simple Game: Heads or Tails

Let's use everything that we have learned to create a simple python heads or tails game! 

This game randomly picks flips a coin and asked the user to guess heads or tails. We flip 5 coins and every time the user gets the correct answer, we add to their score. We save all the tosses and the user guesses to be reported at the end.

> **Note:** To flip a coin we use the python built-in function called `choice()` from a library called `random`. This function returns a random item from a given list. To flip a coin we can simply provide it a list with only two items: `heads` and `tails`

> **Note:** `import` statement is used to _import_ and use other python modules

```python
# import the randint function to be used in our code
from random import choice


number_of_rounds = 5    # how many rounds to play
tosses = []             # empty list to store all the coin tosses
guesses = []            # empty list to store the user guesses
score = 0               # user score

for round in range(1, number_of_rounds + 1):
  print(f"round {round}")
  # flip a coin and ask for the user to guess
  coin = choice(['heads', 'tails'])
  guess = input("Heads or tails? ")
  # append the coin toss and user's guess to be stored
  tosses.append(coin)
  guesses.append(guess)
  # see if the user guessed right
  if coin == guess:
    print("Hooray! You got it right.")
    score = score + 1
  else:
    print(f"Oops, it was {coin}")


# after the loop has ended
# print the report
print(f"Your score is: {score}")
print("Coin tosses :", tosses)
print("Your guesses:", guesses)
```

See if you can re-create this game by yourself. Make some modifications:
- Switch to using a `while` loop and continue the game until the user enters "exit"
- Print some basic stats when you exit the game: number of rounds played, percentage of right choices
  