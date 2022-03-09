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

    solutions = []
    for x in range(5, max_side):
        for y in range(4, max_side):
            for z in range(3, max_side):
                if (x*x==y*y+z*z):
                    # extend instead of append so we get a flat list
                    # in which we can determine the max
                    solutions.extend([x, y, z])

    return max(solutions)

# Keep look & feel
# Input variable renamed so it is senseful
# Make it immediately an integer (will return an error if not a number)
max_side = int(input("What is the maximal length of the triangle side? Enter number: "))

# Use f-string as more readable and no need to convert return of function into string
print(f"The longest side possible is {get_longest_side(max_side)}")
