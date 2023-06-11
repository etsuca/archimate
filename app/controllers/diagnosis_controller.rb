class DiagnosisController < ApplicationController
  skip_before_action :require_login, only: %i[new index]

  def new
    questions = [
      { title: 'コンクリート打ち放しが好き', tag_id: Tag.find(1).id, image: '1.jpg' },
      { title: '木の空間に癒されたい', tag: Tag.find(2).id, image: '2.jpg' },
      { title: 'ガラスの空間が好き', tag_id: Tag.find(3).id, image: '3.jpg' },
      { title: '自然に癒されたい', tag_id: Tag.find(4).id, image: '4.jpg' },
      { title: '私はシティボーイ or シティガール', tag_id: Tag.find(5).id, image: '5.jpg' },
      { title: '静かな空間が好き', tag_id: Tag.find(6).id, image: '6.jpg' },
      { title: '友達とお出掛けするのが好き', tag_id: Tag.find(7).id, image: '7.jpg' },
      { title: 'ほっと一息つける場所が欲しい', tag_id: Tag.find(8).id, image: '8.jpg' },
      { title: '素敵な眺めを楽しみたい', tag_id: Tag.find(9).id, image: '9.jpg' },
      { title: '巨匠の作品に触れたい！', tag_id: Tag.find(10).id, image: '10.jpg' },
      { title: 'モノの歴史に惹かれる', tag_id: Tag.find(11).id, image: '11.jpg' },
      { title: '軽やかな建築が好き', tag_id: Tag.find(12).id, image: '12.jpg' },
      { title: '重厚感のある建築が好き', tag_id: Tag.find(13).id, image: '13.jpg' },
      { title: '日頃のストレスから解放されたい！', tag_id: Tag.find(14).id, image: '14.jpg' },
      { title: '曲線に惹かれる', tag_id: Tag.find(15).id, image: '15.jpg' },
      { title: 'パワーが欲しい！', tag_id: Tag.find(16).id, image: '16.jpg' },
      { title: '常識なんてクソ喰らえ！', tag_id: Tag.find(17).id, image: '17.jpg' },
      { title: '場所が持つストーリーに惹かれる', tag_id: Tag.find(35).id, image: '35.jpg' },
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
