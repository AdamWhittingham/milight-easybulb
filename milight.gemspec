Gem::Specification.new do |s|
  spec.name        = 'milight'
  spec.version     = '0.0.1'
  spec.date        = '2014-04-08'
  spec.summary     = "A ruby interface to Milight control boxes"
  spec.description = "A ruby interface to Milight control boxes"
  spec.authors     = ["Adam Whittingham"]
  spec.email       = "adam.whittingham@gmail.com"
  spec.files       = `git ls-files`.split($/)
  spec.require_paths = ["lib","tasks"]
  s.license        = 'MIT'
end
