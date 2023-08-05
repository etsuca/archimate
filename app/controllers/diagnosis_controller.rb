class DiagnosisController < ApplicationController

  def new
    questions = [
      { title: 'RC打ち放しが好き🏢', tag_id: Tag.find(1).id, image: '1.jpg' },
      { title: '木の温もりが好き🌲', tag_id: Tag.find(2).id, image: '2.jpg' },
      { title: 'ガラスの空間が好き🏙', tag_id: Tag.find(3).id, image: '3.jpg' },
      { title: '自然に癒されたい🍃', tag_id: Tag.find(4).id, image: '4.jpg' },
      { title: '私はシティボーイorシティガール🏙', tag_id: Tag.find(5).id, image: '5.jpg' },
      { title: 'まだ見ぬ場所へ行ってみたい😮', tag_id: Tag.find(6).id, image: '6.jpg' },
      { title: '田舎でゆっくりしたい🌳', tag_id: Tag.find(7).id, image: '7.jpg' },
      { title: '一人でゆっくりする時間が大切🍹', tag_id: Tag.find(8).id, image: '8.jpg' },
      { title: '友達とお出掛けするのが好き👬', tag_id: Tag.find(9).id, image: '9.jpg' },
      { title: '素敵な眺めを楽しみたい👀', tag_id: Tag.find(10).id, image: '10.jpg' },
      { title: '名作を体験してみたい🧐', tag_id: Tag.find(11).id, image: '11.jpg' },
      { title: 'モノの歴史や背景を知りたいと思う😦', tag_id: Tag.find(12).id, image: '12.jpg' },
      { title: '軽やかな空間が好き🍃', tag_id: Tag.find(13).id, image: '13.jpg' },
      { title: '重厚な空間が好き🕋', tag_id: Tag.find(14).id, image: '14.jpg' },
      { title: 'レトロなものが好き🏛', tag_id: Tag.find(15).id, image: '15.jpg' },
      { title: 'リノベーションされた空間が好き🏬', tag_id: Tag.find(16).id, image: '16.jpg' },
      { title: '空が広い場所が好き🌤', tag_id: Tag.find(17).id, image: '17.jpg' },
      { title: '曲線の美しさに惹かれる😳', tag_id: Tag.find(18).id, image: '18.jpg' },
      { title: '素敵な色使いに惹かれる😳', tag_id: Tag.find(19).id, image: '19.jpg' },
      { title: '常識に縛られずに生きていたい🥳', tag_id: Tag.find(20).id, image: '20.jpg' },
      { title: 'シンプルなものが好き💃', tag_id: Tag.find(21).id, image: '21.jpg' }
    ]
    @selected_questions = questions.sample(7)
  end

  def index
    session_key = "architecture_order"
  
    if session[session_key].nil?
      others_architecture = Architecture.where(experience: 0).to_a.shuffle
      session[session_key] = others_architecture.map(&:id)
    else
      shuffled_ids = session[session_key]
      others_architecture = Architecture.where(id: shuffled_ids)
    end

    selected_tag_ids = params[:answer]
    @match_tag_count = [0]
    @matched_architecture = []
  
    others_architecture.each do |architecture|
      architecture.tags.each do |tag|
        if selected_tag_ids&.include?(tag.id.to_s)
          architecture.tmp_match_tag_count += 1
        end
      end
      if @match_tag_count.min < architecture.tmp_match_tag_count
        @match_tag_count << architecture.tmp_match_tag_count
        if @match_tag_count.length > 3
          @match_tag_count.delete(@match_tag_count.min)
        end
        @matched_architecture << architecture
        if @matched_architecture.length > 3
          @matched_architecture.delete(@matched_architecture.min_by { |a| a.tmp_match_tag_count })
        end
      end
    end
  
    @matched_architecture.sort! do |a, b|
      b[:tmp_match_tag_count] <=> a[:tmp_match_tag_count]
    end
  
    if @matched_architecture.length < 3
      redirect_to new_diagnosis_path, notice: 'マッチする建築がありませんでした。もう一度好みを教えてください。'
    end
  end  
end
