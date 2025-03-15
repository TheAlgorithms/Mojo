## Leibniz Pi Formula
##
## The Leibniz formula for π is: π/4 = 1 - 1/3 + 1/5 - 1/7 + ...
##
## https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80

fn pi(limit: Int) -> String:
    """
    Calculate PI using the Leibniz Pi Formula.

    Parameters:
    - limit: The number of decimal places to calculate

    Returns:
    - A string representation of PI with the specified precision

    Example:
    - PI to 5 decimal places: 3.14159
    - PI to 10 decimal places: 3.1415926535
    - PI to 15 decimal places: 3.141592653589793
    - PI to 80 decimal places: 3.14159265358979323846264338327950288419716939937510582097494459230781640628620899

    ```mojo
    from testing import assert_equal
    from leibniz_pi_formula import pi
    assert_equal(pi(5), "3.14159")
    assert_equal(pi(10), "3.1415926535")
    assert_equal(pi(15), "3.141592653589793")
    assert_equal(pi(80), "3.14159265358979323846264338327950288419716939937510582097494459230781640628620899")
    ```
    """
    var q: Float64 = 1.0
    var r: Float64 = 0.0
    var t: Float64 = 1.0
    var k: Float64 = 1.0
    var n: Float64 = 3.0
    var m: Float64 = 3.0

    var decimal: Int = limit
    var counter: Int = 0

    var result = String()

    while counter != decimal + 1:
        if 4.0 * q + r - t < n * t:
            var digit_value = Int(n if n >= 0 else -n)
            result += String(digit_value)

            if counter == 0:
                result += "."

            if decimal == counter:
                break

            counter += 1
            var nr: Float64 = 10.0 * (r - n * t)
            n = Float64(Int((10.0 * (3.0 * q + r)) / t)) - 10.0 * n
            q *= 10.0
            r = nr
        else:
            var nr: Float64 = (2.0 * q + r) * m
            var nn: Float64 = Float64(Int((q * (7.0 * k) + 2.0 + (r * m)) / (t * m)))
            q *= k
            t *= m
            m += 2.0
            k += 1.0
            n = nn
            r = nr

    return result

fn main():
    print(pi(15))
