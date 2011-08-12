version = File.read(File.expand_path("../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.name        = 'spree_zip_code_zone'
  s.version     = version
  s.summary     = 'Add zones based on ZIP code ranges'
  s.description = 'Spree extension to provide zones based on ZIP code ranges'
  s.required_ruby_version = '>= 1.8.7'

  s.authors      = ['Eric Pierce', 'Laurence A. Lee']

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '>= 0.50.99')
end
