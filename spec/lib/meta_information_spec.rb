require './lib/meta_information'

RSpec.describe 'MetaInformation' do
  
  describe 'create_meta_array' do
    describe 'we have meta' do
      it 'must create array' do
        document = Nokogiri::HTML('
          <html>
            <meta name="description" content="" />
            <meta name="title" content="some title" />
            <meta property="author" content="Bob" />
            <meta property="og:title" content="og_title" />
            <meta property="twitter:image" content="http://some_host.com/some_path" />
            <meta property="og:locale" content="ru_RU" />
            <meta property="al:ios:app_store_id" content="12345678900" />
            <body>
              <h1>Mr. Belvedere Fan Club</h1>
            </body>
          </html>
        ')
        expect(MetaInformation.send(:create_meta_array, document)).to eq([
          { type: 'name', name: 'description', content: '' },
          { type: 'name', name: 'title', content: 'some title' },
          { type: 'property', property: 'author', content: 'Bob' },
          { type: 'property', property: 'og:title', content: 'og_title' },
          { type: 'property', property: 'twitter:image', content: 'http://some_host.com/some_path' },
          { type: 'property', property: 'og:locale', content: 'ru_RU' },
          { type: 'property', property: 'al:ios:app_store_id', content: '12345678900' }
        ])
      end
    end
    
    describe 'without meta' do
      it 'has empty array' do
        first_document = Nokogiri::HTML('
          <html>
            <body>
              <h1>Mr. Belvedere Fan Club</h1>
            </body>
          </html>
        ')
        second_document = Nokogiri::HTML('')
        expect(MetaInformation.send(:create_meta_array, first_document)).to eq([])
        expect(MetaInformation.send(:create_meta_array, second_document)).to eq([])
      end
    end
  end

  describe 'valid_url?' do
    it 'must be valid' do
      expect(MetaInformation.send(:valid_url?, 'http://www.somesite.com')).to be_truthy
      expect(MetaInformation.send(:valid_url?, 'https://www.somesite.com')).to be_truthy
      expect(MetaInformation.send(:valid_url?, 'https://somesite.com')).to be_truthy
      expect(MetaInformation.send(:valid_url?, 'wwwsome_site.ru')).to be_truthy
      expect(MetaInformation.send(:valid_url?, 'https://somesite.com/some_page')).to be_truthy
      expect(MetaInformation.send(:valid_url?, 'https://somesite.com/some_page/page')).to be_truthy
      expect(MetaInformation.send(:valid_url?, 'https://somesite.com.uk/some_page')).to be_truthy
    end
    
    it 'does not valid' do
      expect(MetaInformation.send(:valid_url?, 'some_site')).to be_falsey
      expect(MetaInformation.send(:valid_url?, 'http\\:wwwsome_site.ru')).to be_falsey
      expect(MetaInformation.send(:valid_url?, 'com.some_site')).to be_falsey
    end
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
end
