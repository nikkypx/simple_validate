# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple_validate/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_validate"
  spec.version       = SimpleValidate::VERSION
  spec.authors       = ["Nick Palaniuk"]
  spec.email         = ["npalaniuk@gmail.com"]

  spec.summary       = "PORO validation mixin with no deps"
  spec.description   = "PORO validation mixin with no deps"
  spec.homepage      = "https://github.com/nikkypx/simple_validate"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]
end
