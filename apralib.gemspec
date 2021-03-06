# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apralib/version'

Gem::Specification.new do |spec|
  spec.name          = 'apralib'
  spec.version       = Apralib::VERSION
  spec.authors       = ['Marco Sandrini']
  spec.email         = ['nessche@gmail.com']
  spec.description   = %q{A Ruby client for the Apra Service}
  spec.summary       = %q{A Ruby library to submit documents to the Apra Service run by Maatalousyrittäjien eläkelaitos}
  spec.homepage      = 'https://github.com/nessche/apralib'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4.0'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0.0'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.add_development_dependency 'yard'
  spec.add_dependency 'savon', '~> 2.12.0'

end
