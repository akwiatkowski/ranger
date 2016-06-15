# ranger

`ranger` is a Crystal library to operate on `Range` objects in Crystal programming language.
Current version can **include**, **exclude** and two types of **split** `Range` object.

First **split** you choose how many smaller ranges would you like, the second type
allow you to specify range length. It is very useful for `Time` related operations.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  ranger:
    github: akwiatkowski/ranger
```


## Usage

### Include simple ranges

```crystal
require "ranger"

result = (1..2) + (2..3)
puts result.inspect
# [1..3]
```

Keep in mind that you can only include two `Range` objects.
This is because result is `Array(Range)`. If you include two exclusive `Range`
the result are two `Range` objects. That means result of inclusion
cannot be one `Range`.

### Include more than 2 ranges

In case you want to include more objects please use example below.



```crystal
require "ranger"

r = Ranger.new(1..2)
r.include(2..3)
r.include(3..4)

result = r.render
puts result.inspect
# [1..4]
```


### Exclude ranges

Exclusion is opposite operation to inclusion. This library allow you to do it.

```crystal
require "ranger"

result = (1..10) - (5..6)
puts result.inspect
# [1..5, 6..10]
```

### Exclude more ranges

```crystal
require "ranger"

r = Ranger.new(10..20)
r.exclude(15..16)
r.exclude(18..19)

result = r.render
puts result.inspect
# [10..15, 16..18, 19..20]
```

### Divide/split Range into more objects

You can use `ranger` to split one `Range` object into more smaller objects.

```crystal
result = (0..10) / 2
puts result.inspect
# [0..5, 5..10]
```

### Divide/split Range into specific ranges

If you have 1 month `Time` `Range` and would like to divide into 1-week
`Range` objects you can use *modulo* operator - `%`.

```crystal
ra = (Time.new(2016, 1, 1))..(Time.new(2016, 2, 1))
j = Time.new(2016, 1, 8) - Time.new(2016, 1, 1)
result = ra % j
```

Keep in mind last `Range` object will be not full 1-week range. If you would
like only full 1-week ranges you could change operator to *bitwise xor* - `^`.
Sorry, there is lack of proper operators.

```crystal
ra = (Time.new(2016, 1, 1))..(Time.new(2016, 2, 1))
j = Time.new(2016, 1, 8) - Time.new(2016, 1, 1)
result = ra ^ j
```

Alternatively there is method `div`.

```crystal
ra = (Time.new(2016, 1, 1))..(Time.new(2016, 2, 1))
j = Time.new(2016, 1, 8) - Time.new(2016, 1, 1)
result = ra.div(j, allow_partial: false)
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/akwiatkowski/ranger/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [akwiatkowski](https://github.com/akwiatkowski) Aleksander Kwiatkowski - creator, maintainer
