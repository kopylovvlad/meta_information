# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'meta_information/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.1.0'
  s.name        = 'meta_information'
  s.version     = MetaInformation::VERSION
  s.date        = '2021-02-12'
  s.summary     = 'MetaInformation - Simple gem for parsing meta information'
  s.description = 'Simple gem for parsing meta information from websites. It scans all meta-tags by name, itemprop or property attributes.'
  s.author      = 'Vladislav Kopylov'
  s.email       = 'kopylov.vlad@gmail.com'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f =~ /^bin/ }
  s.executables = []
  s.homepage    = 'https://github.com/kopylovvlad/meta_information'
  s.license     = 'MIT'

  s.add_dependency('nokogiri')

  s.add_development_dependency('pry')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rubocop')
end
