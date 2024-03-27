## Absolute Value
##
## The absolute value of a number is the number without its sign.


struct complex:
    var real_part: Int
    var imaginary_part: Int


    fn __init__(inout self: Self, real_part: Int, imaginary_part: Int):
        self.real_part = real_part
        self.imaginary_part = imaginary_part

struct Math:
    @staticmethod
    fn absolute(number: Int) -> Int:
        ## Returns the absolute value of an integer.
        ## >>> Math.absolute(-5)
        ## 5
        ## >>> Math.absolute(5)
        ## 5
        return number if number >= 0 else -number

    @staticmethod
    fn absolute(number: FloatLiteral) -> FloatLiteral:
        ## Returns the absolute value of a float.
        ## >>> Math.absolute(-5.5)
        ## 5.5
        ## >>> Math.absolute(5.5)
        ## 5.5
        return number if number >= 0 else -number


    ## For a complex number z = x + yi,
    ## we define the absolute value |z| as being the distance from z to 0 in the complex plane C.
    ## Reference: https://www2.clarku.edu/faculty/djoyce/complex/abs.html#:~:text=For%20a%20complex%20number%20z,on%20the%20real%20number%20line.
    @staticmethod
    fn absolute(number: complex) -> FloatLiteral:
        ## Returns the absolute value of a complex number.
        ## >>> Math.absolute(complex(5, 12))
        ## 13.0
        ## >>> Math.absolute(complex(3, 4))
        ## 5.0
        return math.sqrt(number.real_part ** 2 + number.imaginary_part ** 2)
