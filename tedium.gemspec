# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tedium/version'

Gem::Specification.new do |spec|
  spec.name          = "tedium"
  spec.version       = Tedium::VERSION
  spec.authors       = ["Stefano Verna"]
  spec.email         = ["s.verna@cantierecreativo.net"]
  spec.summary       = %q{Simplify form filling with SitePrism}
  spec.description   = <<-DESCRIPTION.sub(/^ +/, '')
    Removes the tedium of form filling with SitePrism by allowing you
    to specify a set of fields, actions and submissions rather than 
    procedurally calling Capybara’s DSL methods.
  DESCRIPTION

  spec.homepage      = "https://github.com/cantierecreativo/tedium"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'site_prism', '>= 2.6'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "actionpack"
  spec.add_development_dependency "activemodel"
end

