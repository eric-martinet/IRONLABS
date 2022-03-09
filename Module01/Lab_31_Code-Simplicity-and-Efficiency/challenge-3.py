"""
You are presented with an integer number larger than 5. Your goal is to identify the longest side
possible in a right triangle whose sides are not longer than the number you are given.

For example, if you are given the number 15, there are 3 possibilities to compose right triangles:

1. [3, 4, 5]
2. [6, 8, 10]
3. [5, 12, 13]

The following function shows one way to solve the problem but the code is not ideal or efficient.
Refactor the code based on what you have learned about code simplicity and efficiency.
"""

# Rename function
def get_longest_side(max_side):

    # Original algorithm was testing all possible triangles several times for each of them
    # and the domain cardinality was a cube, resulting in long computations.
    # Since we are looking for the max, we just need to stop when we find it.
    # To ensure it is the max, we can start by the max value and then increment down.
    # We can also order the values of the triangles x > y > z
    # so we make sure we do not test the same triangle several times.

    # We could even make it faster using Fermat's theorem
    # and we first check if x can be expressed as the sum of two squares
    # (if not, no need to run the y & z loops)
    # but other labs await :)

    # Fermat's theorem:
    # A number N is expressible as a sum of 2 squares
    # if and only if in the prime factorization of N,
    # every prime of the form (4k+3) occurs an even number of times.

        for x in range(max_side, 5, -1):
            for y in range(x-1, 4, -1):
                for z in range(y-1, 3, -1):
                    if (x*x == y*y + z*z):
                        print((x,y,z))
                        # solution found, we can return it (which also breaks all loops)
                        return x

# Keep look & feel
# Input variable renamed so it is senseful
# Make it immediately an integer (will return an error if not a number)
max_side = int(input("What is the maximal length of the triangle side? Enter number: "))

# Use f-string as more readable and no need to convert return of function into string
print(f"The longest side possible is {get_longest_side(max_side)}")
