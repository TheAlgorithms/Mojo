## Aliquot Sum
##
## The aliquot sum of a number n is defined as the sum of all natural numbers less than n that divide n evenly.
## https://en.wikipedia.org/wiki/Aliquot_sum

fn aliquot_sum(input_num: Int) raises -> Int:
    """
    Finds the aliquot sum of an input integer.

    Parameters:
    - input_num: A positive integer whose aliquot sum is to be found.
    Returns:
    - The aliquot sum of input_num. If input_num is 1, returns 0 since there are no natural numbers less than 1.
    Raises:
    - Error: If input_num is not positive.

    ```mojo
    from testing import assert_equal, assert_raises
    from aliquot_sum import aliquot_sum
    assert_equal(aliquot_sum(15), 9)
    assert_equal(aliquot_sum(6), 6)
    assert_equal(aliquot_sum(12), 16)
    assert_equal(aliquot_sum(1), 0)
    assert_equal(aliquot_sum(19), 1)
    with assert_raises():
        _ = aliquot_sum(-1)
    with assert_raises():
        _ = aliquot_sum(0)
    ```
    """
    if input_num <= 0:
        raise Error("Input must be positive")

    var sum = 0
    for divisor in range(1, input_num // 2 + 1):
        if input_num % divisor == 0:
            sum += divisor

    return sum
