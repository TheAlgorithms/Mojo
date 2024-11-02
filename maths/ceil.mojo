## Ceiling function
##
## The ceiling function maps a real number x to the smallest integer greater than or equal to x.

# https://en.wikipedia.org/wiki/Floor_and_ceiling_functions

fn ceil(number: Float64) -> Int:
    """
    Return the ceiling of number as an integer.
    
    Parameters:
    - number: A floating-point number.

    Returns:
    - The smallest integer greater than or equal to number.
    
    ```mojo
    from testing import assert_equal
    from ceil import ceil
    assert_equal(ceil(1.1), 2)
    assert_equal(ceil(1.9), 2)
    assert_equal(ceil(1.0), 1)
    assert_equal(ceil(0.0), 0)
    assert_equal(ceil(-1.0), -1)
    assert_equal(ceil(-1.1), -1)
    assert_equal(ceil(-1.9), -1)
    ```
    """
    var int_number = int(number)
    if number - int_number > 0.0:
        return int_number + 1
    return int_number

