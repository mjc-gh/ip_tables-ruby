lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ip_tables/version'

Gem::Specification.new do |spec|
  spec.name          = 'ip_tables'
  spec.version       = IPTables::VERSION
  spec.authors       = ['mikeycgto']
  spec.email         = ['mikeycgto@gmail.com']
  spec.description   = 'A simple Ruby DSL fofr managing IP tables'
  spec.summary       = 'A simple Ruby DSL fofr managing IP tables'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'cocaine', '~> 0.5.1'
  spec.add_dependency 'thor', '~> 0.18.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
end
