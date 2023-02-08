Gem::Specification.new do |spec|
  spec.name = "administrate-field-csv"
  spec.version = "0.1.0"
  spec.authors = ["James Stubblefield"]
  spec.email = ["james@eightbitstudios.com"]

  spec.summary = "CSV field plugin for Administrate"
  spec.description = spec.summary
  spec.homepage = "https://bitbucket.org/eightbitdevelopers/administrate-field-csv"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/src/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "administrate", "< 1.0.0"
  spec.add_runtime_dependency "rails", ">= 4.2"

  spec.add_development_dependency "minitest", "~> 5.0"
end
