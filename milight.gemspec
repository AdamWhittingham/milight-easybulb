# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'milight/version'

Gem::Specification.new do |gem|
  gem.name          = 'milight-easybulb'
  gem.version       = Milight::VERSION
  gem.authors       = ['Adam Whittingham']
  gem.email         = 'adam.whittingham@gmail.com'

  gem.date          = '2014-05-15'
  gem.summary       = 'A ruby interface for Milight and Easybulb LED lights'
  gem.description   = 'A ruby interface for Milight and Easybulb LED lights'
  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.require_paths = ['lib']

  gem.homepage      = 'https://github.com/AdamWhittingham/milight'
  gem.license       = 'MIT'
end
