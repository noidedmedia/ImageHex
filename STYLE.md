The ImageHex Style Guide
========================
This guide provides some basics for the style of code in the ImageHex web
application.

## Ruby

### Formatting
Indent with 2 spaces. NEVER USE TABS.

````ruby
def good
  return true
end
````

Always add a trailing newline to the end of a file.

Try your best not to go over 80 character line widths.

When nesting multiple blocks, use one ````end```` per line:

````ruby
def good
  example do |x|
    puts x
  end
end
````

Leave one newline between methods in a class. Add documentation comments 
for the methods in a class above where they are declared. Do not add
newlines between the start of a class and the start of the first method,
or the end of the last method and the end of a class.
````ruby
class Format
  ##
  # Initialize with an example formatter 
  def initialize(formatter)
    @formatter = formatter
    @formatter.test!
  end

  def test(str)
    @formatter.test(str).map do |x|
      x.format!
    end
  end
end
````

When chaining methods on multiple lines, put the dot before the method:

````ruby
foo.bar
   .baz
   .test
   .image
   .select{|x| x > 3}
````
### Conventions, Constructs, and Naming

You should never have to use a ````for in```` loop. Use constructs like
````.each```` instead.

Prefer transformations like ````map```` and ````select```` over loops.

Use ````snake_case```` for variable and method names, and ````CamelCase```` for
object names. 

When working with numbers, it is okay to use the single-letter variable names
````x````, ````y````, or ````z````. This is especially true in blocks:


````ruby
my_numbers.sort{|x, y| y <=> x }
````


## Javascript

### Formatting

80-character width lines. Newline at the end of each file. Use 2 spaces 
to indent.

Brace formatting should be on the next line for a *named function* and on the
same line for a closure.

Use ````/* comment */```` for multi-line comments. Use ````//```` otherwise.

Comment methods of an object in Javascript above declaration. 
````javascript
function do_thing()
{
  return function(arg){
    attack(x);
  }
}
````

When working with callbacks, put the brace on the same line as the paren:

````javascript
function set_callback(obj)
{
  obj.onComplete(function(data){
    send(data);
  });
}
````

### Conventions, constructs, and naming

Never use ````==````, always use ````===````.

Only use single-letter variable names ````x````, ````y````, and ````z```` for
things you expect to be numbers.

If you have to write something nasty (it's Javascript, it happens), write a
little apology and explination. If it's really gross, and you can prove that
it's the best way to do it, we'll buy you a beer (or Soda of your choice).

