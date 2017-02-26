# MetaInformation
Simple gem for parsing meta information from websites. It scan all meta-tags by name or property attributes.
## Instalation
Add this line to your application's Gemfile:
```ruby
gem 'meta_information'
```
Then run `bundle install`
Or install it yourself as:
```sh
gem install meta_information
```
## Usage
```ruby
require 'pp'
meta = MetaInformation.get_meta('https://www.awesome_site.com/awesome_page')
pp meta
###
#{:succes=>"true",
# :error=>"",
# :all_meta=>
#  [{:type=>"name",
#    :name=>"viewport",
#    :content=>"width=device-width, initial-scale=1.0"},
#   {:type=>"name", :name=>"description", :content=>"some description"},
#   {:type=>"name", :name=>"title", :content=>"i am title"},
#   {:type=>"name", :name=>"og:title", :content=>"some content"},
#   {:type=>"name", :name=>"og:description", :content=>"some description"},
#   {:type=>"name",
#    :name=>"og:image",
#    :content=> "https://www.awesome_site.com/assets/awesome_picture.jpg"}]}
###
```
## License
MIT License.