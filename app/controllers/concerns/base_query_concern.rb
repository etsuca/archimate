module BaseQueryConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_base_query, only: %i(index)
  end

  private

  def set_base_query
    selected_tag_ids = params[:tag_ids] || []

    base_scope = if params[:category] == 'others_building'
                   Building.not_by(current_user).publish
                 elsif params[:category] == 'liked_building'
                   current_user.liked_buildings
                 else
                   current_user.buildings
                 end

    @q = base_scope.ransack(building_search_params)
    @base_query = @q.result

    if selected_tag_ids.present?
      @base_query = @base_query
        .joins(:tags)
        .where(tags: { id: selected_tag_ids })
        .group('buildings.id')
        .having('COUNT(DISTINCT tags.id) = ?', selected_tag_ids.size)
    end
  end

  def building_search_params
    {
      pref_eq: params[:pref].presence,
      name_or_pref_or_location_or_architect_or_description_cont_all: params[:keyword].to_s.gsub(/[[:space:]]+/, ' ').split.presence
    }.compact
  end
end
