# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enriched/version'

Gem::Specification.new do |spec|
  spec.name          = "enriched"
  spec.version       = Enriched::VERSION
  spec.authors       = ["Johannes Opper"]
  spec.email         = ["johannes.opper@gmail.com"]

  spec.summary       = %q{Enrich plain HTML strings with media}
  spec.description   = %q{Enrich plain HTML strings with media}
  spec.homepage      = 'https://github.com/xijo/enrich'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails-html-sanitizer"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
