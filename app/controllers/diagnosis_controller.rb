class DiagnosisController < ApplicationController
  def index
    session_key = 'architecture_order'
    initialize_architecture_session(session_key)

    selected_tag_ids = params[:answer]
    @matched_architecture = find_matched_architecture(selected_tag_ids)

    redirect_to new_diagnosis_path, notice: 'マッチする建築がありませんでした。もう一度好みを教えてください。' if @matched_architecture.length < 3
  end

  def new
    @selected_questions = select_random_questions(7)
  end

  private

  def initialize_architecture_session(session_key)
    return if session[session_key]

    others_architecture = Architecture.where(open_range: 1, experience: 0).to_a.shuffle
    session[session_key] = others_architecture.map(&:id)
  end

  def find_matched_architecture(selected_tag_ids)
    shuffled_ids = session['architecture_order']
    others_architecture = Architecture.where(id: shuffled_ids)
    match_tag_count = 0
    matched_architecture = []

    others_architecture.each do |architecture|
      architecture.tmp_match_tag_count = architecture.tags.where(id: selected_tag_ids).count
      next if match_tag_count >= architecture.tmp_match_tag_count

      match_tag_count = architecture.tmp_match_tag_count
      matched_architecture.push(architecture)
      matched_architecture.sort_by! { |a| -a.tmp_match_tag_count }
      matched_architecture.pop if matched_architecture.length > 3
    end

    matched_architecture
  end

  def select_random_questions(count)
    questions = QuestionsData::QUESTIONS
    questions.sample(count)
  end
end
