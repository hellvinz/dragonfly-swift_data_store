# Dragonfly::SwiftDataStore

Allow storage of [Dragonfly](https://github.com/markevans/dragonfly) objects to a [Swift](http://docs.openstack.org/developer/swift/) object storage

Dragonfly.app.remote_url_for(uid)
This data store also allow serving from Swift (via remote_url see Dragonfly [documentation](http://markevans.github.io/dragonfly/data-stores/))

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dragonfly-swift_data_store'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly-swift_data_store

## Usage

Configure Dragonfly swift datastore initializer with OpenStack credentials: 

```ruby
Dragonfly.app.configure do
  plugin :imagemagick

  secret 'mylongsecret'

  url_format "/media/:job/:name"

  datastore :swift, username: 'username@example.com',
                    api_key: 'apikey',
                    authtenant: 'auththenant',
                    auth_url: 'http://myauth.url',
                    container: 'mycontainer'
end
```

with, as documented by [ruby-openstack](https://github.com/ruby-openstack/ruby-openstack):
- auth_method - Type of authentication - 'password', 'key', 'rax-kskey' - defaults to 'password'
- username - Your OpenStack username or public key, depending on auth_method. *required*
- authtenant_name OR :authtenant_id - Your OpenStack tenant name or id *required*. Defaults to username.
                                      passing :authtenant will default to using that parameter as tenant name.
- api_key - Your OpenStack API key *required* (either private key or password, depending on auth_method)
- auth_url - Configurable auth_url endpoint. *required*
- container - The Swift container name *required*
- service_name - (Optional for v2.0 auth only). The optional name of the compute service to use.
- region - (Optional for v2.0 auth only). The specific service region to use. Defaults to first returned region.
- retry_auth - Whether to retry if your auth token expires (defaults to true)
- proxy_host - If you need to connect through a proxy, supply the hostname here
- proxy_port - If you need to connect through a proxy, supply the port here

## Known limitations

Additional metadata passed on storage will have their value stored as a String

for example: 
```ruby
app = Dragonfly.app
content = Dragonfly::Content.new(app, "gollum")
content.add_meta('bitrate' => 35, 'name' => 'danny.boy')
```

will store 35 as "35"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/hellvinz/dragonfly-swift_data_store/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
