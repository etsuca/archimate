module QuestionsData
  Question = Struct.new(:title, :tag_id, :image, keyword_init: true) 

  QUESTIONS = [
    Question.new(title: 'RC打ち放しが好き🏢', tag_id: 1, image: '1.jpg'),
    Question.new(title: '木の温もりが好き🌲', tag_id: 2, image: '2.jpg'),
    Question.new(title: 'ガラスの空間が好き🏙', tag_id: 3, image: '3.jpg'),
    Question.new(title: '自然に癒されたい🍃', tag_id: 4, image: '4.jpg'),
    Question.new(title: '私はシティボーイorシティガール🏙', tag_id: 5, image: '5.jpg'),
    Question.new(title: 'まだ見ぬ場所へ行ってみたい😮', tag_id: 6, image: '6.jpg'),
    Question.new(title: '田舎でゆっくりしたい🌳', tag_id: 7, image: '7.jpg'),
    Question.new(title: '一人でゆっくりする時間が大切🍹', tag_id: 8, image: '8.jpg'),
    Question.new(title: '友達とお出掛けするのが好き👬', tag_id: 9, image: '9.jpg'),
    Question.new(title: '素敵な眺めを楽しみたい👀', tag_id: 10, image: '10.jpg'),
    Question.new(title: '名作を体験してみたい🧐', tag_id: 11, image: '11.jpg'),
    Question.new(title: 'モノの歴史や背景を知りたいと思う😦', tag_id: 12, image: '12.jpg'),
    Question.new(title: '軽やかな空間が好き🍃', tag_id: 13, image: '13.jpg'),
    Question.new(title: '重厚な空間が好き🕋', tag_id: 14, image: '14.jpg'),
    Question.new(title: 'レトロなものが好き🏛', tag_id: 15, image: '15.jpg'),
    Question.new(title: 'リノベーションされた空間が好き🏬', tag_id: 16, image: '16.jpg'),
    Question.new(title: '空が広い場所が好き🌤', tag_id: 17, image: '17.jpg'),
    Question.new(title: '曲線の美しさに惹かれる😳', tag_id: 18, image: '18.jpg'),
    Question.new(title: '素敵な色使いに惹かれる😳', tag_id: 19, image: '19.jpg'),
    Question.new(title: '常識に縛られずに生きていたい🥳', tag_id: 20, image: '20.jpg'),
    Question.new(title: 'シンプルなものが好き💃', tag_id: 21, image: '21.jpg')
  ].freeze
end
