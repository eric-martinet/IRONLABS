"""
The code below generates a given number of random strings that consists of numbers and 
lower case English letters. You can also define the range of the variable lengths of
the strings being generated.

The code is functional but has a lot of room for improvement. Use what you have learned
about simple and efficient code, refactor the code.
"""

# Declare all imports at the beginning of the file
import random
import string
import sys

# Take out list of possible characters from function declaration
# and use string module to generate it
pwd_patt = string.ascii_lowercase + string.ascii_uppercase + string.digits

def RandomStringGenerator(str_len=12):
    # Transform while loop into list comprehension
    s = [random.choice(pwd_patt) for i in range(str_len)]
    # Return string
    return ''.join(s)

def BatchStringGenerator(nb_rand_str, min_str_len=8, max_str_len=12):
    r = []
    for i in range(nb_rand_str):
        str_len = None
        if min_str_len <= max_str_len:
            # debug: range() does not include stop point
            # so no pwd of length of max_str_len will be generated
            # we add 1 to solve this
            # and so we can merge the conditions min < max and min = max
            str_len = random.choice(range(min_str_len, max_str_len+1))
        else:
            sys.exit('Incorrect min and max string lengths. Try again.')
        # We keep for loop / append instead of list comprehension
        # as it keeps the code more readable
        r.append(RandomStringGenerator(str_len))
    return r

# No change to look & feel
# Variables renamed to be senseful
min_str_len = input('Enter minimum string length: ')
max_str_len = input('Enter maximum string length: ')
nb_rand_str = input('How many random strings to generate? ')

print(BatchStringGenerator(int(nb_rand_str), int(min_str_len), int(max_str_len)))
