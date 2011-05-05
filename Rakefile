# -*- ruby -*-

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rspec/version'
require 'rspec/core/rake_task'
require 'rake/rdoctask'
require 'rbconfig'
require 'hoe'
include Config

# Hoe.plugin :compiler
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
# Hoe.plugin :racc
# Hoe.plugin :rubyforge

Hoe.spec 'win-service' do
  self.name         = 'win-service'
  self.version      = '0.1.0'
  self.author       = 'James T. Pavlic'
  self.email        = 'james_pavlic@hotmail.com'
  self.summary      = 'An interface for MS Windows services'
  self.remote_rdoc_dir = '' # Release to root
  self.url = 'http://codinghappy.blogspot.com/'
 
  self.extra_rdoc_files = [
    'History.txt',
    'README.txt',
    'Manifest.txt'
  ]

  self.description = <<-EOF
      A ruby gem that will allow the basic functions of getting the status,
      stopping and starting of a windows service from both a windows and a mac os x operating system.
  EOF
end

desc 'Install the (non-gem) win-service library.'
task :install_non_gem do
  install_dir = CONFIG['sitelibdir']
  Dir.mkdir(install_dir) unless File.exists?(install_dir)
  FileUtils.cp_r('lib/win', install_dir, :verbose => true)
end

desc 'Uninstall the (non-gem) win-service library.'
task :uninstall_non_gem do
  install_dir = File.join(CONFIG['sitelibdir'], 'win')
  FileUtils.rm_r(install_dir, :verbose => true) if File.exists?(install_dir)
end

desc "Run the test suite for the win-service library."
RSpec::Core::RakeTask.new('rspec') do |t|
  t.pattern = '**/*_spec.rb'
end

desc "Install the win-service gem"
task :install do
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
    gem.files        = Dir['**/*'].delete_if { |f|
    }

    gem.extra_rdoc_files = [
      'History.txt',
      'README.txt',
      'Manifest.txt'
    ]

    gem.rubyforge_project     = 'win-service'
    gem.required_ruby_version = '>= 1.8.7'

    gem.description = <<-EOF
      A ruby gem that will allow the basic functions of getting the status,
      stopping and starting of a windows service from both a windows and a mac os x operating system.
    EOF
  end

  Gem::Builder.new(spec).build

  file = Dir['win-service*.gem'].first
  sh "gem install #{file}"
end

Rake::RDocTask.new do |rdoc|
  files = [ 'README.txt',
            'History.txt',
            'Manifest.txt',
            'doc/*.rdoc',
            'spec/*_spec.rb',
            'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.title = 'win-service documentation'
  rdoc.rdoc_dir = 'doc'
  rdoc.options << '--line-number' << '--inline-source'
end

# vim: syntax=ruby
