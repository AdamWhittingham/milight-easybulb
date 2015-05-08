Gem::Specification.new do |gem|
  gem.name          = 'milight'
  gem.version       = '0.1.0'
  gem.date          = '2014-05-15'
  gem.summary       = 'A ruby interface for Milight bulbs'
  gem.description   = 'A ruby interface for Milight bulbs'
  gem.authors       = ['Adam Whittingham']
  gem.email         = 'adam.whittingham@gmail.com'
  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.require_paths = ['lib']
  gem.homepage      = 'https://github.com/AdamWhittingham/milight'
  gem.license       = 'MIT'
end
