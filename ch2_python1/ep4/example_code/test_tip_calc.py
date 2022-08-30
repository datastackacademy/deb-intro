import pytest
from example_funcs import tip_calculator

# tests for tip_calculator()
def test_tip_calc_ints():
    assert tip_calculator(20, 36) == 43

def test_tip_calc_floats():
    assert tip_calculator(15.5, 36) == 42

def test_str_as_arg():
    assert tip_calculator(20, "hi") == None

def test_wrong_num_args():
    with pytest.raises(Exception) as e:
        tip_calculator(9)


# same as the first three tests above, but using parametrize
@pytest.mark.parametrize("percent, bill, total", [
    (20, 36, 43),
    (15.5, 36, 42),
    (20, "hi", None)
])
def test_correct_total(percent, bill, total):
    assert (tip_calculator(percent, bill)) == total