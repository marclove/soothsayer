# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "soothsayer/version"

Gem::Specification.new do |s|
  s.name        = "soothsayer"
  s.version     = Soothsayer::VERSION
  s.authors     = ["Marc Love"]
  s.email       = ["marcslove@gmail.com"]
  s.homepage    = "http://github.com/marclove/soothsayer"
  s.summary     = %q{A Ruby client for Google's Prediction API}
  s.description = %q{A Ruby client for Google's Prediction API}

  s.rubyforge_project = "soothsayer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "google-api-client"
  s.add_runtime_dependency "multi_json"
end
