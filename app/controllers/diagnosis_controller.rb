class DiagnosisController < ApplicationController
  def index
    session_key = 'building_order'
    initialize_building_session(session_key)

    selected_tag_ids = Array(params[:answer]).map(&:to_i)
    @matched_buildings = find_matched_buildings(selected_tag_ids, session_key)

    redirect_to new_diagnosis_path, notice: 'マッチする建築がありませんでした。もう一度好みを教えてください。' if @matched_buildings.length < 3
  end

  def new
    @selected_questions = select_random_questions(7)
  end

  private

  def initialize_building_session(session_key)
    return if session[session_key]

    building_ids = Building.where(open_range: 1).pluck(:id).shuffle
    # session['building_order'] = [5, 2, 8, 1, 4, 3, 6, 7] みたいな感じ
    # {"building_order" => [5, 2, 8, 1, 4, 3, 6, 7] }みたいなのがセッションに保存される
    session[session_key] = building_ids
  end

  def find_matched_buildings(selected_tag_ids, session_key)
    # セッションからシャッフルされた公開ステータスの全ての建築のIDを取得
    # 例: [5, 2, 8, 1, 4, 3, 6, 7]
    shuffled_ids = session[session_key]

    # シャッフルされたIDに基づいて建築を取得し、IDをキーとしたハッシュに変換
    # buildings_by_idは検索対象の建築が入ったハッシュ
    # 例: {1 => #<Building id: 5, ...>, 2 => #<Building id: 2, ...>, ...}
    buildings_by_id = Building
      .where(id: shuffled_ids)
      .includes(:tags)
      .index_by(&:id)

    shuffled_ids
      # シャッフルされたIDの順番で建築を取得
      # 例: [#<Building id: 5, ...>, #<Building id: 2, ...>, ...]
      .map { |id| buildings_by_id[id] }
      # 各建築に対して、選択されたタグの数をカウントして一時的な属性に保存
      .map do |building|
        building.tmp_match_tag_count = matching_tag_count(building, selected_tag_ids)

        building
      end
      .sort_by { |building| -building.tmp_match_tag_count }
      .first(3)
  end

  def select_random_questions(count)
    QuestionsData::QUESTIONS.sample(count)
  end

  def matching_tag_count(building, selected_tag_ids)
    # 建築のタグの中で、選択されたタグIDと一致するものの数をカウント
    # countにブロックを渡した場合は、ブロックの評価が真となる要素の数を返す
    building.tags.count { |tag| selected_tag_ids.include?(tag.id) }
  end
end
