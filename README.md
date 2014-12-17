ruby-intro-to-enumerable-part-b
===============================

Daily student repository for Enumerable Day 2 (Part B)

## Class Notes

### Ruby Blocks

#### Main Purpose

To understand that we can pass code snippets, or **_blocks_**, of code to *other pieces of code*.

#### Usage

Actually, we have been using blocks since the first week. Think about call `.each` and then... passing it a block, like `do |x| ... end` or `{ |x| ... }`. We have been using blocks this entire time without having a formal name for them.

##### Recall, defining a method:

Recall that we can define methods, and have them take parameters:

```
def print_it(word)
  puts word
end

print_it("Hello") # method print_it is called with String argument "Hello"

print_it("World") # method print_it is called with String argument "World"
```

But methods aren't just forced to take values as parameters, in fact, any `Ruby` object will work as an argument when calling a method. Since everything in `Ruby` is an *object*, we can also pass blocks as arguments to method calls. This illustration is for a method, `any?` (defined elsewhere) that takes two arguments, an `Array` and a *block*, in that order:

![](https://s3-us-west-2.amazonaws.com/lesson-plan-images/block_argument.png)

##### How to Define Methods that Accept Blocks as Parameters:

Recall again defining a method with a single parameter, in this case a `word`:

```
def sandwich_print(word)
  puts word
end
```

`Ruby` is pretty flexible, so actually we can call this method with a block anyway:

```
sandwich_print("Hello") do
  "I'm Jenny from the block!"
end
```

Running this code, we get the same output as if we had run it without the block (e.g. `sandwich_print("Hello")`), so we are missing something.

In order for `Ruby` to know that we are expecting a block as a parameter to the method, `Ruby` utilizes `&` prepended to a variable as the special indicator that this is a block (rather than value) parameter. This is a special language feature and dictates that ***the block parameter must be the last parameter in the method definition and there may only be one such block parameter.*** (as an exercise for the reader, try defining a method in `irb` that takes two blocks are parameters).

```
def sandwich_print(word, &block)
  puts word
end

sandwich_print("Hello") do
  "I'm Jenny from the block!"
end

```

Note, the choice of `&block` is arbitrary, we could call this `&foo` if we wanted to, the special part is the `&` and not the name we give the identifier, or variable name, that follows it.


##### 3 Things to Know About Blocks as Parameters in Method Definitions:

The block parameter:

	1) must be the last parameter,
	   example: GOOD: `def(foo, &block)`, BAD: `def(&block, foo)`

	2) must be prefixed with `&`

	3) must be distinct, that is, there can only be one block parameter accepted


##### A Deeper Example, What if the Block Yields an Argument?

That is to say, blocks are not required to be anonymous, and blocks can themselves take arguments when they are called. For example:

```
def sandwich_print(word, &foo)
  foo.call('foo') # call the block foo, passing in the String argument 'foo'
  puts word
  foo.call('bar') # call the block foo, passing in the String argument 'bar'
end

sandwich_print("Hello") do |phrase|
  puts "#{phrase} from the block"
end
```
which outputs:

```
foo from the block
Hello
bar from the block
```

##### Another example:

Suppose we wanted to implement a method that did something precisely four times, each time giving us the index for reference:

```
def four_times(&block)
  block.call(0)
  block.call(1)
  block.call(2)
  block.call(3)
end

four_times do |number|
  puts "I'm number #{number}"
end
```
which outputs:

```
I'm number 0
I'm number 1
I'm number 2
I'm number 3
```

##### Another Lense for Blocks:


Another way to think of a block is that it is just a set of instructions. When we pass blocks as arguments to methods we are calling, we are constructing the situation where we have some instructions that we want to evaluate, and now we can control when that happens (perhaps based on a condition or some other factor our program is interested in).

An example of this controlled/deferred execution might be a function like this, that takes in two `Date`s, and if the first `Date` is past the second `Date`, executes the provided block, otherwise outputs that it is `"Not time yet"`.

```
def execute_if_time_has_passed(execution_time, desired_time, &block)
  if execution_time > desired_time
  	block.call 
  else
    puts "Not time yet"
  end
end
``` 

##### Recall Our Block Methods:

```
def words_longer_than(words, length)
  result = []

  words.each do |word|
    result << word if word.length > length
  end
  
  result
end

def words_shorter_than(words, length)
  result = []

  words.each do |word|
    result << word if word.length < length
  end
  
  result
end

def words_equal(words, length)
  result = []

  words.each do |word|
    result << word if word.length == length
  end
  
  result
end
```

Here there is a large amount of **duplication**, in fact the methods only vary in a few characters (`<`, `>`, `==`). Imagine if the next feature request is for `words_not_less_than` or similar, now we are defining a fourth method that is again very similar, but not quite the same. Instead of adding more duplication, we can refactor to using a block to contain our variation in logic instead:

```
def select_words(words, &block)
  result = []

  words.each do |word|
    result << word if block.call(word)
  end
  
  result
end
```

which means that we can translate things like `words_longer_than` and `words_shorter_than` into code that looks like this instead:

```
select_words(["foo", "barrrrr", "b"]) do |word|
  word.length > 6
end

select_words(["foo", "barrrrr", "b"]) do |word|
  word.length < 6
end
```

Here we see quite a bit less duplication in the method definitions and only a very small change in how the methods are called.

*note:* `yield` is equivalent to `block.call`, but we will primarily use `block.call`

***definition:*** The `if` statement is a *predicate*. A *predicate* forms a filter (or criteria) against which things are matched/compared.