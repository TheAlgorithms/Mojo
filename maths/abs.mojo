## Absolute Value
##
## The absolute value of a number is the number without its sign.


struct complext:
    var real: Int
    var imag: Int


    fn __init__(inout self: Self, real: Int, imag: Int):
        self.real = real
        self.imag = imag

struct Math:
    @staticmethod
    fn abs(n: Int) -> Int:
        ## Returns the absolute value of an integer.
        ## >>> Math.abs(-5)
        ## 5
        ## >>> Math.abs(5)
        ## 5
        return n if n >= 0 else -n

    @staticmethod
    fn abs(n: FloatLiteral) -> Int:
        ## Returns the absolute value of a float.
        ## >>> Math.abs(-5.5)
        ## 5.5
        ## >>> Math.abs(5.5)
        ## 5.5
        return n if n >= 0 else -n


    ## For a complex number z = x + yi,
    ## we define the absolute value |z| as being the distance from z to 0 in the complex plane C.
    ## Reference: https://www2.clarku.edu/faculty/djoyce/complex/abs.html#:~:text=For%20a%20complex%20number%20z,on%20the%20real%20number%20line.
    @staticmethod
    fn abs(n: complext) -> FloatLiteral:
        ## Returns the absolute value of a complex number.
        ## >>> Math.abs(complext(5, 0))
        ## 5.0
        ## >>> Math.abs(complext(3, 4))
        ## 5.0
        return math.sqrt(n.real ** 2 + n.imag ** 2)
