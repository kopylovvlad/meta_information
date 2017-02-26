$:.push File.expand_path("../lib", __FILE__)
require "meta_information/version"

Gem::Specification.new do |s|
  s.name        = 'meta_information'
  s.version     = MetaInformation::VERSION
  s.date        = '2017-02-26'
  s.summary     = 'MetaInformation - Simple gem for parsing meta information'
  s.description = 'Simple gem for parsing meta information from websites. It scan all meta-tags by name or property attributes.'
  s.author      = 'Vladislav Kopylov'
  s.email       = 'kopylov.vlad@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/kopylovvlad/meta_information'
  s.license     = 'MIT'

  s.add_dependency('nokogiri')
end