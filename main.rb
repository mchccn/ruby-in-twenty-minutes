"Hello world"
# => "Hello World"

=begin
Ruby Obeyed You!
What just happened?
Did we just write the world’s shortest “Hello World” program?
Not exactly.
The second line is just IRB’s way of telling us the result of the last expression it evaluated.
If we want to print out “Hello World” we need a bit more:
=end

puts "Hello world"
# "Hello world"
# => nil

=begin
Your Free Calculator is Here
Already, we have enough to use IRB as a basic calculator:
=end

3 + 2
# => 5

3 * 2
# => 6

3 ** 3
# => 9

Math.sqrt(9)
# => 3.0

=begin
Modules Group Code by Topic
Math is a built-in module for mathematics. Modules serve two roles in Ruby.
This shows one role: grouping similar methods together under a familiar name.
Math also contains methods like sin() and tan().

Next is a dot. What does the dot do?
The dot is how you identify the receiver of a message.
What’s the message?
In this case it’s sqrt(9), which means call the method sqrt, shorthand for “square root” with the parameter of 9.

The result of this method call is the value 3.0.
You might notice it’s not just 3.
That’s because most of the time the square root of a number won’t be an integer, so the method always returns a floating-point number.

What if we want to remember the result of some of this math?
Assign the result to a variable.
=end

a = 3 ** 2
# => 9
b = 4 ** 2
# => 16
Math.sqrt(a+b)
# => 5.0
