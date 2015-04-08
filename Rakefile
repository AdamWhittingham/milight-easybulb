require 'rake/clean'
require 'rake-n-bake'

task :default => [
  :clean,
  :"bake:code_quality:all",
  :"bake:rspec",
  :"bake:coverage:check_specs",
  :"bake:ok_rainbow",
]
