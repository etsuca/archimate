class DiagnosisController < ApplicationController
  def index
    session_key = 'building_order'
    initialize_building_session(session_key)

    selected_tag_ids = params[:answer]
    @matched_building = find_matched_building(selected_tag_ids)

    redirect_to new_diagnosis_path, notice: 'マッチする建築がありませんでした。もう一度好みを教えてください。' if @matched_building.length < 3
  end

  def new
    @selected_questions = select_random_questions(7)
  end

  private

  def initialize_building_session(session_key)
    return if session[session_key]

    others_building = Building.where(open_range: 1, experience: 0).to_a.shuffle
    session[session_key] = others_building.map(&:id)
  end

  def find_matched_building(selected_tag_ids)
    shuffled_ids = session['building_order']
    building_by_id = Building.where(id: shuffled_ids).includes(:tags).index_by(&:id)
    others_building = shuffled_ids.filter_map { |id| building_by_id[id] }
    match_tag_count = [0]
    matched_building = []

    others_building.each do |building|
      building.tmp_match_tag_count = building.tags.where(id: selected_tag_ids).count
      next if match_tag_count.min >= building.tmp_match_tag_count

      match_tag_count << building.tmp_match_tag_count
      match_tag_count.delete(match_tag_count.min) if match_tag_count.length > 3

      matched_building.push(building)
      matched_building.sort_by! { |a| -a.tmp_match_tag_count }
      matched_building.pop if matched_building.length > 3
    end

    matched_building
  end

  def select_random_questions(count)
    questions = QuestionsData::QUESTIONS
    questions.sample(count)
  end
end
