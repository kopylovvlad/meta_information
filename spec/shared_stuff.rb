RSpec.shared_context 'shared stuff', shared_context: :metadata do
  let(:default_html) do
    '
      <html>
        <meta name="description" content="" />
        <meta name="title" content="some title" />
        <meta property="author" content="Bob" />
        <meta property="og:title" content="og_title" />
        <meta property="twitter:image" content="http://some_host.com/some_path" />
        <meta property="og:locale" content="ru_RU" />
        <meta property="al:ios:app_store_id" content="12345678900" />
        <meta itemprop="name" content="site name"/>
        <meta itemprop="description" content="site description"/>
        <body>
          <h1>Mr. Belvedere Fan Club</h1>
        </body>
      </html>
    '
  end

  let(:default_html_meta_array) do
    [
      {
        type: 'name',
        name: 'description',
        property: nil,
        itemprop: nil,
        content: ''
      },
      {
        type: 'name',
        name: 'title',
        property: nil,
        itemprop: nil,
        content: 'some title'
      },
      {
        type: 'property',
        name: nil,
        property: 'author',
        itemprop: nil,
        content: 'Bob'
      },
      {
        type: 'property',
        name: nil,
        property: 'og:title',
        itemprop: nil,
        content: 'og_title'
      },
      {
        type: 'property',
        name: nil,
        property: 'twitter:image',
        itemprop: nil,
        content: 'http://some_host.com/some_path'
      },
      {
        type: 'property',
        name: nil,
        property: 'og:locale',
        itemprop: nil,
        content: 'ru_RU'
      },
      {
        type: 'property',
        name: nil,
        property: 'al:ios:app_store_id',
        itemprop: nil,
        content: '12345678900'
      },
      {
        type: 'itemprop',
        name: nil,
        property: nil,
        itemprop: 'name',
        content: 'site name'
      },
      {
        type: 'itemprop',
        name: nil,
        property: nil,
        itemprop: 'description',
        content: 'site description'
      }
    ]
  end
end
