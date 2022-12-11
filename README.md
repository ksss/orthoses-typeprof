# Orthoses::TypeProf

Orthoses extention for [TypeProf](https://github.com/ruby/typeprof).

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add orthoses-typeprof

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install orthoses-typeprof

## Usage

```rb
require 'orthoses/typeprof'

Orthoses::Build.new do
  use Orthoses::CreateFileByName,
    base_dir: 'out'
  # Orthoses::TypeProf load RBS from current store to TypeProf.
  # It means that the RBS determined so far is used as a reference value for TypeProf.
  use Orthoses::TypeProf,
    # `TypeProf::ConfigData` is an option class in TypeProf
    # `config` passed directly to `TypeProf.analyze(config)`
    config: TypeProf::ConfigData.new(
      rb_files: Dir["lib/**/*.rb"],
      collection_path: ::RBS::Collection::Config::PATH,
    )
  run -> { }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ksss/orthoses-typeprof. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ksss/orthoses-typeprof/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Orthoses::Typeprof project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ksss/orthoses-typeprof/blob/main/CODE_OF_CONDUCT.md).
