module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'archimate'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
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
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('lp_top.jpg'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary'
      }
    }
  end

  def build_tweet_text(matched_building)
    text = 'マッチングした建築は…%0a%0a'
    matched_building.each_with_index do |building, index|
      text += "#{index + 1}. 「#{building.name}」"
      text += building.architect.to_s if building.architect.present?
      text += '%0a'
    end
    text += '%0aでした！%0a'
    text
  end

  def all_prefectures_options
    [
      '北海道',
      '青森県',
      '岩手県',
      '宮城県',
      '秋田県',
      '山形県',
      '福島県',
      '茨城県',
      '栃木県',
      '群馬県',
      '埼玉県',
      '千葉県',
      '東京都',
      '神奈川県',
      '新潟県',
      '富山県',
      '石川県',
      '福井県',
      '山梨県',
      '長野県',
      '岐阜県',
      '静岡県',
      '愛知県',
      '三重県',
      '滋賀県',
      '京都府',
      '大阪府',
      '兵庫県',
      '奈良県',
      '和歌山県',
      '鳥取県',
      '島根県',
      '岡山県',
      '広島県',
      '山口県',
      '徳島県',
      '香川県',
      '愛媛県',
      '高知県',
      '福岡県',
      '佐賀県',
      '長崎県',
      '熊本県',
      '大分県',
      '宮崎県',
      '鹿児島県',
      '沖縄県'
    ]
  end
end
