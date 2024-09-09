## Addition Without Arithmetic
"""
Illustrate how to add the integer without arithmetic operation
Author: Tiyagora Yetalit, based on suraj Kumar's https://github.com/TheAlgorithms/Python/blob/master/maths/addition_without_arithmetic.py
Time Complexity: 1
https://en.wikipedia.org/wiki/Bitwise_operation
"""


fn add(owned first: Int, owned second: Int) -> Int:
    """
    Implementation of addition of integer

    Examples:
    >>> add(3, 5)
    8
    >>> add(13, 5)
    18
    >>> add(-7, 2)
    -5
    >>> add(0, -7)
    -7
    >>> add(-321, 0)
    -321
    """
    while second != 0:
        var c = first & second
        first ^= second
        second = c << 1
    return first
