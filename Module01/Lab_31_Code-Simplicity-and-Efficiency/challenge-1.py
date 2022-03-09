"""
This is a dumb calculator that can add and subtract whole numbers from zero to five.
When you run the code, you are prompted to enter two numbers (in the form of English
word instead of number) and the operator sign (also in the form of English word).
The code will perform the calculation and give the result if your input is what it
expects.

The code is very long and messy. Refactor it according to what you have learned about
code simplicity and efficiency.
"""

# Global variables
# Dictionary to link user's number inputs (a and b) with their actual numeric value
inp_nb_dict = {'zero':0, 'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5}

# Same as above, but for output
out_nb_dict = {v:k for (k,v) in inp_nb_dict.items()}

# Dictionary to link user's operator input with their actual python operator
inp_op_dict = {'plus':'+', 'minus': '-'}


# No change to messages inputs to keep the same look & feel
print('Welcome to this calculator!')
print('It can add and subtract whole numbers from zero to five')
a = input('Please choose your first number (zero to five): ')
b = input('What do you want to do? plus or minus: ')
c = input('Please choose your second number (zero to five): ')



# Try... except structure: if the user enters inputs that are out of range, display error message.

try:
    # Transform 'zero plus zero' into '0+0' string that can be evaluated by Python
    user_inp_eval = f'{inp_nb_dict[a]}{inp_op_dict[b]}{inp_nb_dict[c]}'

    # No security issue, as the program first tries to compile the string before evaluating it
    # and the compilation of the string will result in an error if the input values are not in the dictionaries
    result_val = eval(user_inp_eval)
    
    # Transform back to number in plain text
    result_str = out_nb_dict[result_val]

    # Display result
    print('%s %s %s equals %s' % (a, b, c, result_str))
except:
    print("I am not able to answer this question. Check your input.")

print("Thanks for using this calculator, goodbye :)")
