import pytest
from example_funcs import describe_iterable

def test_list_of_int_str_and_list():
    assert describe_iterable([1, "cat", [1, 4, 5]]) == 'This iterable is 3 items long. \n' \
    "The item at index 0 is '1'. Its data type is <class 'int'> \n" \
    "The item at index 1 is 'cat'. Its data type is <class 'str'> \n" \
    "The item at index 2 is '[1, 4, 5]'. Its data type is <class 'list'> \n"

