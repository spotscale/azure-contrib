# Azure::Contrib

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'azure-contrib', git: 'https://github.com/dmichael/azure-contrib.git'

And then execute:

    $ bundle


## Usage

Its a start 

```ruby
  
signer = Azure::Contrib::Auth::SharedAccessSignature.new(uri, {
  resource:    'c',
  permissions: 'w',
  start:       (Time.now - 5*60).utc.iso8601,
  expiry:      (Time.now + 30*60).utc.iso8601
})

signed_uri = signer.sign


```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/azure-contrib/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
