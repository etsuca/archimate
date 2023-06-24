module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'archimate'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: 'archimate',
      title: 'archimate - 建築を記録し、新たな建築に出会うためのプラットフォーム',
      reverse: true,
      charset: 'utf-8',
      description: 'archimateは、建築を記録し、新たな建築に出会うためのプラットフォームです。クールな建築を見つけましょう。',
      keywords: '建築,近くの建築,建築家,旅行,デザイン,建築探訪',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('lp_top.jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        # site: '@ツイッターのアカウント名',
      }
    }
  end
end