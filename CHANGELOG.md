## [Unreleased]

## [1.0.0]

- Require Administrate 1.0 (`administrate >= 1.0`) and support Rails 8
- Declare `csv` as a runtime dependency (extracted from Ruby's default gems in Ruby 3.4)
- Ship the field's stylesheet as plain CSS so it loads under both Sprockets and Propshaft (Propshaft serves assets verbatim and runs no SCSS compiler or Sprockets directives); the Sprockets precompile registration is now guarded so it is a no-op elsewhere
- Remove the redundant `to_partial_path` override; Administrate 1.0 resolves partials through `partial_prefixes`
- Remove the unused `_field` partial and the dead engine root assignment
- Move the project from Bitbucket to https://github.com/jameswilliamiii/administrate-field-csv and migrate CI to GitHub Actions

## [0.1.0] - 2023-02-08

- Initial release
