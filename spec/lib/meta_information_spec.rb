# frozen_string_literal: true

require './lib/meta_information'
require './spec/shared_stuff'
require './spec/config'

RSpec.describe 'MetaInformation' do
  include_context 'shared stuff'

  describe 'get_meta' do
    it 'should return not_valid_url_error' do
      allow(MetaInformation).to receive(:valid_url?).and_return(false)
      result = MetaInformation.get_meta('http://some_url.com')
      expect(result).to(
        eq(
          success: false,
          error: 'url is not valid'
        )
      )
    end

    it 'should return not_valid_url_scheme_error' do
      result = MetaInformation.get_meta('ftp://some_url.com')
      expect(result).to(
        eq(success: false, error: 'url must be http(s)')
      )
    end

    describe 'with mock for valid_url?' do
      before do
        allow(MetaInformation).to receive(:valid_url?).and_return(true)
      end
      it 'should return nokogiri_error' do
        allow(MetaInformation).to receive(:create_document).and_return(false)

        result = MetaInformation.get_meta('http://some_url.com')
        expect(result).to(
          eq(
            success: false,
            error: 'error with parsing a document'
          )
        )
      end

      it 'should return success_hash' do
        allow(MetaInformation).to(
          receive(:create_document).and_return(
            Nokogiri::HTML(default_html)
          )
        )

        result = MetaInformation.get_meta('http://some_url.com')
        expect(result).to(
          eq(
            succes: 'true',
            error: '',
            all_meta: default_html_meta_array
          )
        )
      end
    end
  end

  describe 'create_meta_array' do
    describe 'we have meta' do
      it 'must create array' do
        document = Nokogiri::HTML(default_html)
        result = MetaInformation.send(:create_meta_array, document)
        expect(result).to eq(default_html_meta_array)
      end
    end

    describe 'without meta has empty array' do
      it 'if have not mate' do
        first_document = Nokogiri::HTML('
          <html>
            <body>
              <h1>Mr. Belvedere Fan Club</h1>
            </body>
          </html>
        ')
        expect(MetaInformation.send(:create_meta_array, first_document)).to eq([])
      end

      it 'if html is empty' do
        second_document = Nokogiri::HTML('')
        expect(MetaInformation.send(:create_meta_array, second_document)).to eq([])
      end
    end
  end

  describe 'valid_url?' do
    def self.validate_valid_url(url)
      it "#{url} must be valid" do
        expect(MetaInformation.send(:valid_url?, url)).to be_truthy
      end
    end

    validate_valid_url('http://www.somesite.com')
    validate_valid_url('https://www.somesite.com')
    validate_valid_url('https://somesite.com')
    validate_valid_url('http://www.siteforadmin.ru')
    validate_valid_url('https://somesite.com/some_page')
    validate_valid_url('https://somesite.com/some_page/page')
    validate_valid_url('http://somesite.com/some_page/2012/12/page/another_page')
    validate_valid_url('http://somesite.com/2012/12/page-page-page')
    validate_valid_url('https://somesite.com.uk/some_page')
    validate_valid_url('https://meduza.io/short/2017/03/25/v-londone-proshel-mnogotysyachnyy-marsh-protiv-brekzita-fotografiya')

    def self.validate_invalid_url(url)
      it "#{url} must be invalid" do
        expect(MetaInformation.send(:valid_url?, url)).to be_falsey
      end
    end

    validate_invalid_url('some_site')
    validate_invalid_url('http\\:wwwsome_site.ru')
    validate_invalid_url('com.some_site')
  end

  describe 'private hash equal' do
    it 'not_valid_url_error hash' do
      expect(MetaInformation.send(:not_valid_url_error)).to eq({
                                                                 success: false,
                                                                 error: 'url is not valid'
                                                               })
    end

    it 'nokogiri_error hash' do
      expect(MetaInformation.send(:nokogiri_error)).to eq({
                                                            success: false,
                                                            error: 'error with parsing a document'
                                                          })
    end

    it 'success_hash hash' do
      expect(MetaInformation.send(:success_hash)).to eq({
                                                          succes: 'true',
                                                          error: ''
                                                        })
    end
  end

  describe 'node_type' do
    it 'must return name' do
      document = Nokogiri::HTML('<meta name="description" content="" />')
      node = document.css('meta').first
      expect(MetaInformation.send(:node_type, node)).to eq('name')
    end

    it 'must return property' do
      document = Nokogiri::HTML(
        '<meta property="og:title" content="og_title" />'
      )
      node = document.css('meta').first
      expect(MetaInformation.send(:node_type, node)).to eq('property')
    end

    it 'must return property' do
      document = Nokogiri::HTML(
        '<meta itemprop="description" content="description" />'
      )
      node = document.css('meta').first
      expect(MetaInformation.send(:node_type, node)).to eq('itemprop')
    end

    it 'must return nil' do
      document = Nokogiri::HTML('<meta content="og_title" />')
      node = document.css('meta').first
      expect(MetaInformation.send(:node_type, node)).to eq(nil)
    end
  end
end
