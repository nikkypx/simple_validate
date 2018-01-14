lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_validate/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_validate'
  spec.version       = SimpleValidate::VERSION
  spec.authors       = ['Nick Palaniuk']
  spec.email         = ['npalaniuk@gmail.com']

  spec.summary       = 'Validations for any plain old ruby object'
  spec.description   = 'Validations for any ruby object'
  spec.homepage      = 'https://github.com/nikkypx/simple_validate'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ['lib']
  spec.add_dependency 'activesupport', '~> 5.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
