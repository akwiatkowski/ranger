# ranger

Library to operate on `Range` objects in Crystal programming language.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  ranger:
    github: akwiatkowski/ranger
```


## Usage

### Include ranges

```crystal
require "ranger"

r = Ranger.new(1..2)
r.include(2..3)

result = r.render
puts result.inspect
# [1..3]
```

### Exclude ranges

```crystal
require "ranger"

r = Ranger.new(10..20)
r.exclude(15..16)

result = r.render

result = r.render
puts result.inspect
# [10..15, 16..20]
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
