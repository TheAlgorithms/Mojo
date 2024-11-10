## Average mean
## Find mean of a list of numbers.
## Wiki: https://en.wikipedia.org/wiki/Mean.

fn mean(nums: List[Int]) raises -> Float64:
    """
    Parameters:
    - nums: List of integers.

    Returns:
    - Mean of the list of numbers.

    ```mojo
    from testing import assert_almost_equal, assert_raises
    from average_mean import mean
    DELTA = 1e-6
    assert_almost_equal(mean(List(5, 10, 15, 20, 25, 30, 35)), 20.0, atol=DELTA)
    assert_almost_equal(mean(List(1, 2, 3, 4, 5, 6, 7, 8)), 4.5, atol=DELTA)
    assert_almost_equal(mean(List(3, 6, 9, 12, 15, 18, 21)), 12.0, atol=DELTA)
    with assert_raises():
        var empty = List[Int]()
        _ = mean(empty)
    ```
    """
    if len(nums) == 0:
        raise Error("List is empty")

    var list_sum = 0.0
    for num in nums:
        list_sum += num[]

    return list_sum / len(nums)
