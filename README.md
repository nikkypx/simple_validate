# Simple Validate

> PORO validation mixin with no deps

## Installation

```ruby
gem 'simple_validate'
```

## Usage

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

### Type

```ruby
  validates_type_of :attribute, as: :string
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

### Inclusion and Exclusion

```ruby
  validates_inclusion_of :domain, in: [:net, :com]
  validates_exclusion_of :name, in: [:Bojack, :Horseman]
```

### Options

#### Custom error messages

* It is possible to pass a custom error message to any validation.

```ruby
  validates_presence_of :attribute, message: 'attribute is required!'
```

#### Conditional validation

* It is possible to pass an `if` option with a proc for a conditional validation

```ruby
  validates_presence_of :attribute, if: Proc.new { true }
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).