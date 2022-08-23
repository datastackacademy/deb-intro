# example 3: add breakpoints to lines 7 and 8
# try 'step into' vs 'step over'

def say_meow():
    return "meow"

def cat_namer(name):
    cat_noise = say_meow()  # call a function within a function
    print(f'{name} says {cat_noise}')

# call your 'cat_namer' function with an argument passed to the 'name' parameter
cat_namer('Fuzzle')