Gem::Specification.new do |s|
  s.name          = 'colorized_logs'
  s.version       = '0.1.0'
  s.authors       = ['Luis Cuevas']
  s.email         = ['lcuevastodoit@gmail.com']
  s.summary       = 'A gem that colorizes Ruby on Rails logs output.'
  s.description   = 'A gem that colorizes Ruby on Rails logs output.'
  s.homepage      = 'https://github.com/lcuevastodoit/colorized_logs'
  s.license       = 'GPL-3.0-or-later'
  s.files         = Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.add_dependency 'activesupport', '>= 4.2.0'
end
