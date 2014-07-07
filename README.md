# Microsoft Azure SDK for Ruby ... Extensions!

This was written as a container to add functionality missing from the Azure SDK, specifically the Shared Access Signature which is needed for CORS requests from JavaScript, among other things

This bit of code was written with the help of these sources:
* http://msdn.microsoft.com/en-us/library/dn140255.aspx
* http://msdn.microsoft.com/en-us/library/azure/dn140256.aspx

## Installation

Add this line to your application's Gemfile:

    gem 'azure-contrib', git: 'https://github.com/dmichael/azure-contrib.git'

And then execute:

    $ bundle


## Usage

### Shared Access Signatures 

```ruby
  
signer = Azure::Contrib::Auth::SharedAccessSignature.new(uri, {
  resource:    'c',
  permissions: 'w',
  start:       (Time.now - 5*60).utc.iso8601,
  expiry:      (Time.now + 30*60).utc.iso8601
})

signed_uri = signer.sign


```

### Chunked Uploads

For files > 64MB you will need chunk your uploads. While the Azure Ruby SDK does provide the methods for doing this, the process of chunking is fiddly and requires a great deal of supporting code.

This gem overrides the `create_block_blob` to add chunking support.

```ruby
container = <your container name>
blob      = <your blob name>

service = Azure::BlobService.new
service = create_block_blob(container, blob, 'path/to/file', chunking: true)
```

All options like `:timeout` may still be passed as usual. Without the `chunking: true` option, the original method is called untouched.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/azure-contrib/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
