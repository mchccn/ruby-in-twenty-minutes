"Hello World"
# => "Hello World"

=begin
What just happened?
Did we just write the world’s shortest “Hello World” program?
Not exactly.
The second line is just IRB’s way of telling us the result of the last expression it evaluated.
If we want to print out “Hello World” we need a bit more:
=end

puts "Hello World"
# "Hello World"
# => nil

=begin
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

=begin
What if we want to say “Hello” a lot without getting our fingers all tired? We need to define a method!
=end

def hi
  puts "Hello World!"
end
# => :hi

=begin
Now let’s try running that method a few times:
=end

hi
# "Hello World"
# => nil

hi()
# "Hello World"
# => nil

=begin
Well, that was easy. Calling a method in Ruby is as easy as just mentioning its name to Ruby.
If the method doesn’t take parameters that’s all you need. You can add empty parentheses if you’d like, but they’re not needed.

What if we want to say hello to one person, and not the whole world?
Just redefine hi to take a name as a parameter.
=end

def hi(name)
  puts "Hello #{name}!"
end
# => :hi

hi("Matz")
# Hello Matz!
# => nil

=begin
What’s the #{name} bit? That’s Ruby’s way of inserting something into a string.
The bit between the braces is turned into a string (if it isn’t one already) and then substituted into the outer string at that point. 
You can also use this to make sure that someone’s name is properly capitalized:
=end

def hi(name = "World")
  puts "Hello #{name.capitalize}!"
end
# => :hi

hi "chris"
# Hello Chris!
# => nil

hi
# Hello World!
# => nil

=begin
A couple of other tricks to spot here. One is that we’re calling the method without parentheses again.
If it’s obvious what you’re doing, the parentheses are optional. The other trick is the default parameter World.
What this is saying is “If the name isn’t supplied, use the default name of "World"”.

What if we want a real greeter around, one that remembers your name and welcomes you and treats you always with respect.
You might want to use an object for that. Let’s create a “Greeter” class.
=end

class Greeter
  def initialize(name = "World")
    @name = name
  end
  def say_hi
    puts "Hi #{@name}!"
  end
  def say_bye
    puts "Bye #{@name}, come back soon."
  end
end
# => :say_bye

=begin
The new keyword here is class. This defines a new class called Greeter and a bunch of methods for that class.
Also notice @name. This is an instance variable, and is available to all the methods of the class.
As you can see it’s used by say_hi and say_bye.
=end

greeter = Greeter.new("Pat")
# => #<Greeter:0x16cac @name="Pat">

greeter.say_hi
# Hi Pat!
# => nil
greeter.say_bye
# Bye Pat, come back soon.
# => nil

=begin
Once the greeter object is created, it remembers that the name is Pat. Hmm, what if we want to get at the name directly?
=end

greeter.@name
# !> SyntaxError: unexpected tIVAR, expecting '('

Greeter.instance_methods
# => [:say_hi, :say_bye, :instance_of?, :public_send,
#     :instance_variable_get, :instance_variable_set,
#     :instance_variable_defined?, :remove_instance_variable,
#     :private_methods, :kind_of?, :instance_variables, :tap,
#     :is_a?, :extend, :define_singleton_method, :to_enum,
#     :enum_for, :<=>, :===, :=~, :!~, :eql?, :respond_to?,
#     :freeze, :inspect, :display, :send, :object_id, :to_s,
#     :method, :public_method, :singleton_method, :nil?, :hash,
#     :class, :singleton_class, :clone, :dup, :itself, :taint,
#     :tainted?, :untaint, :untrust, :trust, :untrusted?, :methods,
#     :protected_methods, :frozen?, :public_methods, :singleton_methods,
#     :!, :==, :!=, :__send__, :equal?, :instance_eval, :instance_exec, :__id__]


=begin
Whoa. That’s a lot of methods. We only defined two methods.
What’s going on here? Well this is all of the methods for Greeter objects, a complete list, including ones defined by ancestor classes.
If we want to just list methods defined for Greeter we can tell it to not include ancestors by passing it the parameter false, meaning we don’t want methods defined by ancestors.
=end

Greeter.instance_methods(false)
# => [:say_hi, :say_bye]

greeter.respond_to?("name")
# => false

greeter.respond_to?("say_hi")
# => true

greeter.respond_to?("to_s")
# => true

=begin
So, it knows say_hi, and to_s (meaning convert something to a string, a method that’s defined by default for every object), but it doesn’t know name.

But what if you want to be able to view or change the name? Ruby provides an easy way of providing access to an object’s variables.
=end

class Greeter
  attr_accessor :name
end
# => nil

greeter = Greeter.new("Andy")
# => #<Greeter:0x3c9b0 @name="Andy">
greeter.respond_to?("name")
# => true
greeter.respond_to?("name=")
# => true
greeter.say_hi
# Hi Andy!
# => nil
greeter.name="Betty"
# => "Betty"
greeter
# => #<Greeter:0x3c9b0 @name="Betty">
greeter.name
# => "Betty"
greeter.say_hi
# Hi Betty!
# => nil

=begin
Using attr_accessor defined two new methods for us, name to get the value, and name= to set it.

This greeter isn’t all that interesting though, it can only deal with one person at a time. What if we had some kind of MegaGreeter that could either greet the world, one person, or a whole list of people?

Let’s write this one in a file instead of directly in the interactive Ruby interpreter IRB.

To quit IRB, type “quit”, “exit” or just hit Control-D.
=end

#!/usr/bin/env ruby

class MegaGreeter
  attr_accessor :names

  # Create the object
  def initialize(names = "World")
    @names = names
  end

  # Say hi to everybody
  def say_hi
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
      # @names is a list of some kind, iterate!
      @names.each do |name|
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}!"
    end
  end

  # Say bye to everybody
  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      # Join the list elements with commas
      puts "Goodbye #{@names.join(", ")}.  Come back soon!"
    else
      puts "Goodbye #{@names}.  Come back soon!"
    end
  end
end


if __FILE__ == $0
  mg = MegaGreeter.new
  mg.say_hi
  mg.say_bye

  # Change name to be "Zeke"
  mg.names = "Zeke"
  mg.say_hi
  mg.say_bye

  # Change the name to an array of names
  mg.names = ["Albert", "Brenda", "Charles",
              "Dave", "Engelbert"]
  mg.say_hi
  mg.say_bye

  # Change to nil
  mg.names = nil
  mg.say_hi
  mg.say_bye
end

# Hello World!
# Goodbye World.  Come back soon!
# Hello Zeke!
# Goodbye Zeke.  Come back soon!
# Hello Albert!
# Hello Brenda!
# Hello Charles!
# Hello Dave!
# Hello Engelbert!
# Goodbye Albert, Brenda, Charles, Dave, Engelbert.  Come
# back soon!
# ...
# ...

=begin
So, looking deeper at our new program, notice the initial lines, which begin with a hash mark (#).
In Ruby, anything on a line after a hash mark is a comment and is ignored by the interpreter.
The first line of the file is a special case, and under a Unix-like operating system tells the shell how to run the file.
The rest of the comments are there just for clarity.

Our say_hi method has become a bit trickier:
=end

def say_hi
  if @names.nil?
    puts "..."
  elsif @names.respond_to?("each")
    # @names is a list of some kind, iterate!
    @names.each do |name|
      puts "Hello #{name}!"
    end
  else
    puts "Hello #{@names}!"
  end
end

=begin
If the @names object responds to each, it is something that you can iterate over, so iterate over it and greet each person in turn.
Finally, if @names is anything else, just let it get turned into a string automatically and do the default greeting.

Let’s look at that iterator in more depth:
=end

@names.each do |name|
  puts "Hello #{name}!"
end

=begin
The real power of blocks is when dealing with things that are more complicated than lists.
Beyond handling simple housekeeping details within the method, you can also handle setup, teardown, and errors—all hidden away from the cares of the user.
=end

# Say bye to everybody
def say_bye
  if @names.nil?
    puts "..."
  elsif @names.respond_to?("join")
    # Join the list elements with commas
    puts "Goodbye #{@names.join(", ")}.  Come back soon!"
  else
    puts "Goodbye #{@names}.  Come back soon!"
  end
end

=begin
The say_bye method doesn’t use each, instead it checks to see if @names responds to the join method, and if so, uses it.
Otherwise, it just prints out the variable as a string.
This method of not caring about the actual type of a variable, just relying on what methods it supports is known as “Duck Typing”, as in “if it walks like a duck and quacks like a duck…”.
The benefit of this is that it doesn’t unnecessarily restrict the types of variables that are supported.
If someone comes up with a new kind of list class, as long as it implements the join method with the same semantics as other lists, everything will work as planned.
=end

if __FILE__ == $0
end

=begin
__FILE__ is the magic variable that contains the name of the current file.
$0 is the name of the file used to start the program.
This check says “If this is the main file being used…”
This allows a file to be used as a library, and not to execute code in that context, but if the file is being used as an executable, then execute that code.
=end

=begin
So that’s it for the quick tour of Ruby.
There’s a lot more to explore, the different control structures that Ruby offers; the use of blocks and yield; modules as mixins; and more.
I hope this taste of Ruby has left you wanting to learn more.
=end
