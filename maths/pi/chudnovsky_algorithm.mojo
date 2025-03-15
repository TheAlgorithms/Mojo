## Chudnovsky Algorithm
##
## The Chudnovsky algorithm is a fast method for calculating the digits of PI,
## based on Ramanujan's PI formulae. This algorithm converges much more rapidly
## than most other PI algorithms - each iteration gives approximately 14 additional
## digits of PI.
##
## Implementation Notes:
## - This implementation uses Mojo's built-in floating-point arithmetic (Float64),
##   which limits the practical precision to about 15-16 significant digits.
## - For higher precision, a dedicated arbitrary-precision arithmetic library would be required.
##
## https://en.wikipedia.org/wiki/Chudnovsky_algorithm

from math import sqrt, ceil

fn factorial(n: Int) -> Int:
    """
    Calculate the factorial of a number.

    Parameters:
    - n: The number to calculate factorial for

    Returns:
    - n!

    Note: This implementation will overflow for large inputs.
    """
    if n <= 1:
        return 1
    var result = 1
    for i in range(2, n + 1):
        result *= i
    return result

fn repeat_zero(count: Int) -> String:
    """
    Create a string of '0' characters repeated count times.

    Parameters:
    - count: Number of times to repeat the '0' character

    Returns:
    - A string of '0's of specified length
    """
    var result = String()
    for i in range(count):
        result += "0"
    return result

fn pi(precision: Int) raises -> String:
    """
    Calculate PI using the Chudnovsky algorithm.

    The Chudnovsky algorithm is defined as:
    PI = constant_term / ((multinomial_term * linear_term) / exponential_term)
    where constant_term = 426880 * sqrt(10005)

    The linear_term and exponential_term are defined iteratively:
    L_k+1 = L_k + 545140134            where L_0 = 13591409
    X_k+1 = X_k * -262537412640768000  where X_0 = 1

    The multinomial_term is defined as:
    6k! / ((3k)! * (k!)^3)

    Parameters:
    - precision: The number of decimal places to calculate

    Returns:
    - A string representation of PI with the specified precision

    Raises:
    - Error: If precision is less than 1

    Examples:
    - PI to 5 decimal places: 3.14159
    - PI to 10 decimal places: 3.1415926535
    - PI to 15 decimal places: 3.141592653589793

    ```mojo
    from testing import assert_equal, assert_raises
    from chudnovsky_algorithm import pi
    assert_equal(pi(5), "3.14159")
    assert_equal(pi(10), "3.1415926535")
    assert_equal(pi(15), "3.141592653589793")
    with assert_raises():
        _ = pi(-1)  # Should raise error for negative precision
    ```

    For calculations requiring scientific accuracy, more digits of PI may be needed:
    - In particle physics and astronomy, up to 15 digits may be used
    - For most engineering applications, 5-7 digits are usually sufficient

    Note: Due to the limitations of floating-point arithmetic and factorial calculation,
    this implementation is practical only for small precision values (up to ~15 digits).
    For higher precision calculations, see the optimized_pi function below which uses
    binary splitting for better performance.
    """
    if precision < 1:
        raise Error("Undefined for non-natural numbers")

    # Constants for the Chudnovsky algorithm
    var constant_term = 426880.0 * sqrt(10005.0)
    var linear_term = 13591409.0
    var exponential_term = 1.0
    var partial_sum = linear_term

    # Calculate the number of iterations needed
    var num_iterations = ceil(precision / 14)

    for k in range(1, num_iterations + 1):
        # Calculate multinomial term: 6k! / ((3k)! * (k!)^3)
        var multinomial_term = Float64(factorial(6 * k)) / (Float64(factorial(3 * k)) * Float64(factorial(k) ** 3))

        # Update terms for next iteration
        linear_term += 545140134.0
        exponential_term *= -262537412640768000.0

        # Update partial sum
        partial_sum += (multinomial_term * linear_term) / exponential_term

    # Calculate PI
    var pi_value = constant_term / partial_sum

    # Convert to string and format to the specified precision
    var pi_str = String(pi_value)

    # Take only the required number of decimal places
    var parts = pi_str.split(".")
    if len(parts) < 2:  # No decimal point
        return parts[0] + "." + repeat_zero(precision)

    var integer_part = parts[0]
    var decimal_part = parts[1]

    if len(decimal_part) >= precision:
        return integer_part + "." + decimal_part[:precision]
    else:
        return integer_part + "." + decimal_part + repeat_zero(precision - len(decimal_part))


fn binary_split(a: Int, b: Int) -> Tuple[Float64, Float64, Float64]:
    """
    Perform binary splitting computation for the Chudnovsky algorithm.

    This is a highly optimized approach that reduces the computational complexity
    from O(n²) to O(n log n) making it much more efficient for large numbers of digits.

    Parameters:
    - a: Start of the interval
    - b: End of the interval

    Returns:
    - Tuple containing (Pab, Qab, Rab) intermediate values
    """
    if b == a + 1:
        # Base case
        var Pab = -Float64((6*a - 5)*(2*a - 1)*(6*a - 1))
        var Qab = 10939058860032000.0 * Float64(a*a*a)
        var Rab = Pab * (545140134.0*Float64(a) + 13591409.0)
        return (Pab, Qab, Rab)
    else:
        # Recursive case - split the computation
        var m = (a + b) // 2
        var Pam_tuple = binary_split(a, m)
        var Pmb_tuple = binary_split(m, b)

        var Pam = Pam_tuple[0]
        var Qam = Pam_tuple[1]
        var Ram = Pam_tuple[2]

        var Pmb = Pmb_tuple[0]
        var Qmb = Pmb_tuple[1]
        var Rmb = Pmb_tuple[2]

        var Pab = Pam * Pmb
        var Qab = Qam * Qmb
        var Rab = Qmb * Ram + Pam * Rmb

        return (Pab, Qab, Rab)


fn optimized_pi(precision: Int) raises -> String:
    """
    Calculate PI using the optimized Chudnovsky algorithm with binary splitting.

    This implementation uses a binary splitting technique that dramatically improves
    performance for large numbers of digits. The algorithm has O(n log n) complexity
    compared to the standard implementation.

    Parameters:
    - precision: The number of decimal places to calculate

    Returns:
    - A string representation of PI with the specified precision

    Raises:
    - Error: If precision is less than 1

    ```mojo
    from testing import assert_equal
    from chudnovsky_algorithm import pi, optimized_pi
    assert_equal(optimized_pi(5), "3.14159")
    assert_equal(optimized_pi(10), "3.1415926535")
    assert_equal(optimized_pi(15), "3.141592653589793")

    # But the optimized version is much faster for large precision
    ```

    Note: This implementation is still limited by Mojo's Float64 precision.
    For truly arbitrary precision, specialized libraries would be needed.
    """
    if precision < 1:
        raise Error("Undefined for non-natural numbers")

    # Calculate the number of iterations needed
    var n = ceil(precision / 14) + 1

    # Compute the binary splitting algorithm
    var result = binary_split(1, Int(n))
    var P = result[0]
    var Q = result[1]
    var R = result[2]

    # Compute PI using the formula
    var pi_value = (426880.0 * sqrt(10005.0) * Q) / (13591409.0*Q + R)

    # Convert to string and format to the specified precision
    var pi_str = String(pi_value)

    # Take only the required number of decimal places
    var parts = pi_str.split(".")
    if len(parts) < 2:  # No decimal point
        return parts[0] + "." + repeat_zero(precision)

    var integer_part = parts[0]
    var decimal_part = parts[1]

    if len(decimal_part) >= precision:
        return integer_part + "." + decimal_part[:precision]
    else:
        return integer_part + "." + decimal_part + repeat_zero(precision - len(decimal_part))
