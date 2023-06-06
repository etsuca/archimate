class DiagnosisController < ApplicationController
  skip_before_action :require_login, only: %i[new index]

  def new
  end

  def index
    others_architecture = Architecture.where.not(user_id: current_user&.id).where(experience: 0)
    selected_tag_ids = params[:answer]
    @match_tag_count = [0]
    tmp_match_tag_count = 0
    @matched_architecture = []
    @all_tmp_match_tag_count = []

    others_architecture.each do |architecture|
      tmp_match_tag_count = 0
      architecture.tags.each do |tag|
        if selected_tag_ids&.include?(tag.id.to_s)
          tmp_match_tag_count += 1
        end
      end
      if @match_tag_count&.min < tmp_match_tag_count
        @match_tag_count << tmp_match_tag_count
        if @match_tag_count.length > 3
          @match_tag_count&.delete(@match_tag_count.min)
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
