# a function that can only accept numbers
def tip_calculator(percent: float, bill: float) -> int:
    try:
        percent_as_decimal = percent/100
        tip = percent_as_decimal * bill
        return(round(tip + bill))
    except:
        return(None)

# a function with a default keyword arg
def say_hi(name = None) -> str:
    if name != None:
        return(f"Hi, {name}!")
    else:
        return(f"Hey, what's your name?")

# a function that requires an iterable as an argument
def describe_iterable(iterable: list) -> str:
    description = ""
    description += f"This iterable is {len(iterable)} items long. \n"
    for index in range(len(iterable)):
        description +=f"The item at index {index} is '{iterable[index]}'. "
        description +=f"Its data type is {type(iterable[index])} \n"
    return description
