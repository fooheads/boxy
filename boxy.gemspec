# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boxy/version'

Gem::Specification.new do |spec|
  spec.name          = "boxy"
  spec.version       = Boxy::VERSION
  spec.authors       = ["Jon-Erling Dahl", "Niclas Nilsson"]
  spec.email         = ["jon-erling@fooheads.com", "niclas@fooheads.com"]

  spec.summary       = %q{Automates installation of mac computers}
  spec.homepage      = "https://github.com/fooheads/boxy"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "table_print"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.required_ruby_version = '~> 2.0'
end
