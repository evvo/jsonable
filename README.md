# jsonable

Json helper that will simplify common json outputs for objects.
It can help you build and scaffold JSON APIs faster, by providing simple to use json mappings.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     jsonable:
       github: evvo/jsonable
   ```

2. Run `shards install`

## Usage

```crystal
class User
  include Jsonable
  getter test_field = ["string1", "string2"]
  public_json_fields [["test_field"]]
end

user = User.new
user.get_json # { "test_field" : ["string1", "string2"] }

```

The `public_json_fields` are the fields that will be included when you call the `get_json` method.
`public_json_fields` has 2 params - for single entry and for a collection (optional):

```crystal
class User
  include Jsonable
  getter test_field = ["string1", "string2"]
  getter test_field_for_collection = ["string1", "string2"]
  public_json_fields [["test_field"], ["test_field_for_collection"]]
end

user = User.new
user2 = User.new

User.get_json_collection([user, user2]) # [{ "test_field_for_collection" : ["string1", "string2"] } ...]

```

## Testing

You can run the tests, by executing

```console
foo@bar:~$ crystal spec
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/evvo/jsonable/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Evtimiy Mihaylov](https://github.com/evvo) - creator and maintainer
