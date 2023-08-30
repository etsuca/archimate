module BaseQueryConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_base_query, only: [:index, :search]
  end

  private

  def set_base_query
    selected_tag_ids = params[:tag_ids] || []
    selected_pref = params[:pref]
    keyword = params[:keyword]

    if params[:category] == 'others_architecture'
      @base_query = Architecture.not_by(current_user)
    elsif params[:category] == 'liked_architecture'
      @base_query = current_user.like_architecture
    else
      @base_query = Architecture.where(user_id: current_user.id)
    end

    if selected_tag_ids.present?
      @base_query = @base_query.joins(:tags).where(tags: { id: selected_tag_ids.first })
      selected_tag_ids[1..-1].each do |tag_id|
        @base_query = @base_query.where(id: Architecture.joins(:tags).where(tags: { id: tag_id }))
      end
    end

    if selected_pref.present?
      @base_query = @base_query.where(pref: selected_pref)
    end

    if keyword.present?
      keywords = keyword.split
      keywords.each do |kw|
        @base_query = @base_query.where('architecture.name LIKE ? OR architecture.pref LIKE ? OR architecture.location LIKE ? OR architecture.architect LIKE ? OR architecture.description LIKE ?', "%#{kw}%", "%#{kw}%", "%#{kw}%", "%#{kw}%", "%#{kw}%")
      end
    end
  end
end