# IpTables

Simple DSL for writing and building IP tables rule sets.

## Example

Here's a quick example of the DSL:

```ruby
chain :in, default: :drop do
  accept src: '192.168.1.0/24', dst: :any do
    match :tcp, dport: [22, 80, 443]
    match :udp, dport: 53
  end
end

chain :out, default: :accept
chain :forward, default: :drop
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
