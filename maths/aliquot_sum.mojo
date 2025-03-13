## Aliquot Sum
##
## The aliquot sum of a number n is defined as the sum of all natural numbers less than n that divide n evenly.
## This implementation provides both a basic O(n) approach and an optimized O(sqrt(n)) version.
## https://en.wikipedia.org/wiki/Aliquot_sum

fn aliquot_sum(input_num: Int) raises -> Int:
    """
    Finds the aliquot sum of an input integer.
    
    The aliquot sum is the sum of all proper divisors of a number (all positive divisors less than the number itself).
    This is a simple O(n) implementation that directly follows the definition.
    
    Parameters:
    - input_num: A positive integer whose aliquot sum is to be found.
    Returns:
    - The aliquot sum of input_num. If input_num is 1, returns 0 since there are no natural numbers less than 1.
    Raises:
    - Error: If input_num is not positive.
    
    Examples:
    - The aliquot sum of 12 is 1 + 2 + 3 + 4 + 6 = 16
    - The aliquot sum of 6 is 1 + 2 + 3 = 6 (perfect number)
    - The aliquot sum of 15 is 1 + 3 + 5 = 9
    - The aliquot sum of 19 is 1 (prime numbers only have 1 as a proper divisor)
    - The aliquot sum of 1 is 0 (there are no natural numbers less than 1)
    
    ```mojo
    from testing import assert_equal, assert_raises
    from aliquot_sum import aliquot_sum, optimized_aliquot_sum
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

fn optimized_aliquot_sum(input_num: Int) raises -> Int:
    """
    Optimized implementation of aliquot sum with O(sqrt(n)) time complexity.
    
    This implementation leverages the mathematical property that divisors come in pairs:
    if i is a divisor of n, then n/i is also a divisor. By iterating only up to sqrt(n),
    we can find all divisor pairs and significantly improve performance.
    
    Parameters:
    - input_num: A positive integer whose aliquot sum is to be found.
    Returns:
    - The aliquot sum of input_num.
    Raises:
    - Error: If input_num is not positive.
    """
    if input_num <= 0:
        raise Error("Input must be positive")
    
    var sum = 1  # Start with 1 as it's always a divisor for positive numbers
    if input_num == 1:
        return 0  # Special case: aliquot sum of 1 is 0
        
    # Find all divisor pairs up to sqrt(input_num)
    var i = 2
    while i * i <= input_num:
        if input_num % i == 0:
            sum += i
            # Add the pair if they're not the same (perfect square case)
            if i != input_num // i:
                sum += input_num // i
        i += 1
    
    return sum