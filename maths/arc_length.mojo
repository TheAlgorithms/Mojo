## Arc Length
##
## Finds the arc length of a circle given central angle (degrees) and radius values.

fn arc_length(angle: Int, radius: Int) -> Float64:
    """
    >>> arc_length(45, 5)
    3.9269908169872414
    >>> arc_length(120, 15)
    31.415926535897928
    >>> arc_length(90, 10)
    15.707963267948966
    """
    return 2 * 3.1416 * radius * (angle / 360)
