require 'meta_information/version'
require 'nokogiri'
require 'open-uri'

# MetaInformation - module for scaning meta information
# form web page
# for usage
# MetaInformation.get_meta('https://some_site.com/some_page')
module MetaInformation
  extend self

  def get_meta(input_url)
    return not_valid_url_error unless valid_url?(input_url)

    document = create_document(input_url)
    return nokogiri_error if document == false

    meta_hash = create_meta_array(document)
    success_hash.merge(all_meta: meta_hash)
  end

  private

  def create_meta_array(document)
    array = []
    document.css('meta').each do |node|
      array.push(
        type: node_type(node),
        name: node['name'],
        property: node['property'],
        content: node['content']
      )
    end
    array
  end

  def node_type(node)
    if !node['name'].nil?
      'name'
    elsif !node['property'].nil?
      'property'
    else
      ''
    end
  end

  def valid_url?(uri)
    !(uri =~ URI.regexp).nil?
  end

  def create_document(input_url)
    Nokogiri::HTML(open(input_url))
  rescue
    false
  end

  def not_valid_url_error
    {
      success: false,
      error: 'url is not valid'
    }
  end

  def nokogiri_error
    {
      success: false,
      error: 'error with parsing a document'
    }
  end

  def success_hash
    {
      succes: 'true',
      error: ''
    }
  end
end
