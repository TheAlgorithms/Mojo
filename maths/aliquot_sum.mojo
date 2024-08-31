'''
    Finds the aliquot sum of an input integer, where the
    aliquot sum of a number n is defined as the sum of all
    natural numbers less than n that divide n evenly. For
    example, the aliquot sum of 15 is 1 + 3 + 5 = 9. This is
    a simple O(n) implementation.
    @param input_num: a positive integer whose aliquot sum is to be found
    @return: the aliquot sum of input_num, if input_num is positive.
    Otherwise, raise an Error
    Wikipedia Explanation: https://en.wikipedia.org/wiki/Aliquot_sum
'''

fn aliquot_sum(input_num: Int) raises -> Int:
  '''
    >>> aliquot_sum(15)
    9
    >>> aliquot_sum(6)
    6
    >>> aliquot_sum(-1)
    Error: Input must be positive
    >>> aliquot_sum(0)
    Error: Input must be positive
    >>> aliquot_sum(12)
    16
    >>> aliquot_sum(1)
    0
    >>> aliquot_sum(19)
    1
  .'''
    if input_num <= 0:
        raise Error("Input must be positive")
    var _sum = 0
    for divisor in range(1, input_num // 2 + 1):
      if input_num % divisor == 0:
        _sum += divisor
    return _sum
