# frozen_string_literal: true

require_relative 'meta_information/version'
require 'nokogiri'
require 'uri'
require 'net/http'

# MetaInformation - module for scaning meta information from web page
# MetaInformation.get_meta('https://some_site.com/some_page')
module MetaInformation
  extend self

  def get_meta(input_url)
    return not_valid_url_error unless valid_url?(input_url)
    return not_valid_url_scheme unless valid_url_scheme?(input_url)

    document = create_document(input_url)
    return nokogiri_error if document == false

    meta_hash = create_meta_array(document)
    success_hash.merge(all_meta: meta_hash)
  end

  private

  # TODO: change to struct
  def create_meta_array(document)
    document
      .css('meta').reject { |node| node_type(node).nil? }
      .map do |node|
        {
          type: node_type(node),
          name: node['name'],
          property: node['property'],
          content: node['content'],
          itemprop: node['itemprop']
        }
      end
  end

  def node_type(node)
    if !node['name'].nil?
      'name'
    elsif !node['property'].nil?
      'property'
    elsif !node['itemprop'].nil?
      'itemprop'
    else
      nil
    end
  end

  def valid_url?(uri)
    !(uri =~ URI::DEFAULT_PARSER.make_regexp).nil?
  end

  def valid_url_scheme?(input_url)
    URI(input_url).is_a?(URI::HTTP)
  end

  def create_document(input_url)
    uri = URI(input_url)
    res = Net::HTTP.get_response(uri)

    raise 'Response code is not 2xx' if !(res.code.to_i >= 200 && res.code.to_i <= 299)
    raise 'Response is without body' unless res.class.body_permitted?

    Nokogiri::HTML(res.body)
  rescue StandardError => e
    puts e
    false
  end

  def not_valid_url_error
    {
      success: false,
      error: 'url is not valid'
    }
  end

  def not_valid_url_scheme
    {
      success: false,
      error: 'url must be http(s)'
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
