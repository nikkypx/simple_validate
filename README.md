# Simple Validate

[![Build Status](https://travis-ci.org/nikkypx/simple_validate.svg?branch=master)](https://travis-ci.org/nikkypx/simple_validate)

Borrowing ideas from [validatable](https://github.com/jnunemaker/validatable) and Rails validations, this is a library for validations for any ruby object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_validate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_validate

## Usage

### Example

```ruby
require 'simple_validate'

class Person
  include SimpleValidate
  attr_accessor :name, :age
  
  validates_presence_of :name, :age
  validates_numericality_of :age
end
```

```ruby
=> p = Person.new
=> #<Person:0x007f9431536408>
=> p.valid?
=> false
=> p.errors
=> #<SimpleValidate::Errors:0x007f94318b4df0
 @messages=
  {:age=>["can't be empty", "must be a number"],
   :name=>["can't be empty"]}>
```

### Presence

```ruby
  validates_presence_of :attribute
```

### Numericality

```ruby
  validates_numericality_of :attribute
```

### Format

```ruby
  validates_format_of :attribute, with: /[A-Z]+/
```

### Length

* Possible length options include: `maximum`, `minimum`, `in`, `is`.

* `maximum`, `minimum` and `is` take a single integer and `in` takes a range.

```ruby
  validates_length_of :attribute, in: 6..9
```

### Custom error messages

* It is possible to pass a custom error message to any validation.

```ruby
  validates_presence_of :attribute, message: 'attribute is required!'
```

### Conditional validation

* It is possible to pass an `if` option with a proc for a conditional validation

```ruby
  validates_presence_of :attribute, if: Proc.new { true }
```


## Development

`$ rake` to run the specs


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nikkypx/simple_validate.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

