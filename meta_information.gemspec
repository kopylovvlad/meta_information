$:.push File.expand_path("../lib", __FILE__)
require "meta_information/version"

Gem::Specification.new do |s|
  s.name        = 'meta_information'
  s.version     = MetaInformation::VERSION
  s.date        = '2017-02-26'
  s.summary     = 'MetaInformation - Simple gem for parsing meta information'
  s.description = 'MetaInformation - Simple gem for parsing meta information'
  s.authors     = ['Vladislav Kopylov']
  s.email       = 'kopylov.vlad@gmail.com'
  s.files       = ['lib/meta_information.rb']
  s.homepage    = 'http://rubygems.org/gems/meta_information'
  s.license     = 'MIT'
end