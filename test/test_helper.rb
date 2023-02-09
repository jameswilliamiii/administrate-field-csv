# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "administrate/field/csv"

require "minitest/autorun"
require "minitest/spec"

def lorem(n)
  "a" * n
end
