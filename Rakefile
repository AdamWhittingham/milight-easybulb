require 'rake/clean'
require 'rake-n-bake'
require 'bundler/gem_tasks'

task default: [
  :clean,
  :"bake:code_quality:all",
  :"bake:rspec",
  :"bake:coverage:check_specs",
  :"bake:rubocop",
  :"bake:ok_rainbow"
]
