# Administrate::Field::CSV

A custom [Administrate](https://github.com/thoughtbot/administrate) field to present Strings with CSV content in a table format on you show views.
This field uses truncated text for index views, and a text area for form views.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate-field-csv'
```

And then execute:

    $ bundle install

Add the below to your `app/assets/config/manifest.js` if your administrate configuration is using the asset pipeline.

```javascript
//= link administrate-field-csv/application.css
```

## Usage

```
ATTRIBUTE_TYPES = {
    # ...
    csv_text: Field::CSV.with_options(
      headers: true,
      col_sep: ',',
      row_sep: "\r\n",
      quote_char: '"',
      return_headers: false,
      truncate: 50,
      blank_sign: "--"
    )
}
```

All possible options for the field are shown above along with their default values.  Refer to the ruby CSV documentation for details around the possible values for `headers`, `col_sep`, `row_sep`, `quote_char` and `return_headers`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `administrate-field-csv.gemspec`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on Bitbucket at [https://bitbucket.org/eightbitdevelopers/administrate-field-csv](https://bitbucket.org/eightbitdevelopers/administrate-field-csv).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
