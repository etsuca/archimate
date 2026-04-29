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

    @base_query = if params[:category] == 'others_building'
                    Building.not_by(current_user).where(open_range: 1)
                  elsif params[:category] == 'liked_building'
                    current_user.liked_buildings
                  else
                    Building.where(user_id: current_user.id)
                  end

    if selected_tag_ids.present?
      @base_query = @base_query.joins(:tags).where(tags: { id: selected_tag_ids.first })
      selected_tag_ids[1..].each do |tag_id|
        @base_query = @base_query.where(id: Building.joins(:tags).where(tags: { id: tag_id }))
      end
    end

    @base_query = @base_query.where(pref: selected_pref) if selected_pref.present?

    if keyword.present?
      keywords = keyword.split
      keywords.each do |kw|
        @base_query = @base_query.where('buildings.name LIKE ? OR buildings.pref LIKE ? OR buildings.location LIKE ? OR buildings.architect LIKE ? OR buildings.description LIKE ?', "%#{kw}%", "%#{kw}%", "%#{kw}%", "%#{kw}%", "%#{kw}%")
      end
    end
  end
end
