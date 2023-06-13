class DiagnosisController < ApplicationController
  skip_before_action :require_login, only: %i[new index]

  def new
    questions = [
      { title: 'RC打ち放しが好き', tag_id: Tag.find(1).id, image: '1.jpg' },
      { title: '木の空間に癒されたい', tag: Tag.find(2).id, image: '2.jpg' },
      { title: 'ガラスの空間が好き', tag_id: Tag.find(3).id, image: '3.jpg' },
      { title: '自然に癒されたい', tag_id: Tag.find(4).id, image: '4.jpg' },
      { title: '私はシティボーイ or シティガール', tag_id: Tag.find(5).id, image: '5.jpg' },
      { title: 'まだ見ぬ場所へ行ってみたい', tag_id: Tag.find(6).id, image: '6.jpg' },
      { title: '静かな空間が好き', tag_id: Tag.find(7).id, image: '7.jpg' },
      { title: '友達とお出掛けするのが好き', tag_id: Tag.find(8).id, image: '8.jpg' },
      { title: '一人でゆっくりする時間が大切', tag_id: Tag.find(9).id, image: '9.jpg' },
      { title: '素敵な景色はテンション上がる', tag_id: Tag.find(10).id, image: '10.jpg' },
      { title: '巨匠の作品に触れてみたい！', tag_id: Tag.find(11).id, image: '11.jpg' },
      { title: 'モノが持つ歴史に惹かれる', tag_id: Tag.find(12).id, image: '12.jpg' },
      { title: '軽やかに生きていたい', tag_id: Tag.find(13).id, image: '13.jpg' },
      { title: 'レトロなものに心惹かれる', tag_id: Tag.find(14).id, image: '14.jpg' },
      { title: 'モノ持ちが良い方だ', tag_id: Tag.find(15).id, image: '15.jpg' },
      { title: '日頃のストレスから解放されたい！', tag_id: Tag.find(16).id, image: '16.jpg' },
      { title: '曲線の美しさに惹かれる', tag_id: Tag.find(17).id, image: '17.jpg' },
      { title: '直線の美しさに心が惹かれる', tag_id: Tag.find(18).id, image: '18.jpg' },
      { title: '論理より感性に忠実でいたい', tag_id: Tag.find(19).id, image: '19.jpg' },
      { title: '常識に縛られずに生きていたい', tag_id: Tag.find(20).id, image: '20.jpg' },
      { title: '自分はミニマリストだ', tag_id: Tag.find(21).id, image: '21.jpg' },
    ]
    @selected_questions = questions.sample(5)
  end

  def index
    others_architecture = Architecture.where.not(user_id: current_user&.id).where(experience: 0)
    selected_tag_ids = params[:answer]
    @match_tag_count = [0]
    @matched_architecture = []
    @all_tmp_match_tag_count = []

    others_architecture.each do |architecture|
      tmp_match_tag_count = 0
      architecture.tags.each do |tag|
        if selected_tag_ids&.include?(tag.id.to_s)
          tmp_match_tag_count += 1
        end
      end
      if @match_tag_count.min < tmp_match_tag_count
        @match_tag_count << tmp_match_tag_count
        if @match_tag_count.length > 3
          @match_tag_count.delete(@match_tag_count.min)
        end
        @matched_architecture << architecture
        if @matched_architecture.length > 3
          @matched_architecture&.delete(@matched_architecture.min)
        end
      end
    end
    if @matched_architecture.length < 3
      redirect_to new_diagnosis_path, notice: 'マッチする建築がありませんでした。もう一度好みを教えてください。'
    end
  end
end
