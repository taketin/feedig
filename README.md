# Feedig

Feedig is Feed IRC Gateway, forked hsbt's [agig.rb](https://github.com/hsbt/agig)

## Installation

`$ git clone git@github.com:taketin/feedig.git`

## Usage

```
$ cd feedig

# Add the feed url to 'resources.yml'

$ ./bin/feedig -d

# join '#notification' channel in your IRC client.
```


change the interval to fetch

```
$ ./bin/feedig -d -i #{second}
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/feedig/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
