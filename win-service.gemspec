require 'rubygems'

spec = Gem::Specification.new do |gem|
   gem.name         = 'win-service'
   gem.version      = '0.1.0'
   gem.authors      = ['James T. Pavlic']
   gem.email        = 'james_pavlic@hotmail.com'
   gem.license      = 'The MIT License'
   gem.homepage     = 'https://github.com/jpavlic/win-service'
   gem.platform     = Gem::Platform::RUBY
   gem.summary      = 'An interface for MS Windows services'
   gem.add_development_dependency('rspec')
   gem.has_rdoc     = true

   gem.extra_rdoc_files = [
    'History.txt',
    'README.txt',
    'Manifest.txt',     
    'doc/service.rdoc'
   ]

   gem.rubyforge_project     = 'win-service'
   gem.required_ruby_version = '>= 1.8.7'

   gem.description = <<-EOF
      A ruby gem that will allow the basic functions of getting the status,
      stopping and starting of a windows service from both a windows and a mac os x operating system.
   EOF
end

if $PROGRAM_NAME == __FILE__
   Gem.manage_gems if Gem::RubyGemsVersion.to_f < 1.0
   Gem::Builder.new(spec).build
end
