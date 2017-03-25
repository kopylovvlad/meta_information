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
        content: ''
      },
      {
        type: 'name',
        name: 'title',
        property: nil,
        content: 'some title'
      },
      {
        type: 'property',
        name: nil,
        property: 'author',
        content: 'Bob'
      },
      {
        type: 'property',
        name: nil,
        property: 'og:title',
        content: 'og_title'
      },
      {
        type: 'property',
        name: nil,
        property: 'twitter:image',
        content: 'http://some_host.com/some_path'
      },
      {
        type: 'property',
        name: nil,
        property: 'og:locale',
        content: 'ru_RU'
      },
      {
        type: 'property',
        name: nil,
        property: 'al:ios:app_store_id',
        content: '12345678900'
      }
    ]
  end
end
