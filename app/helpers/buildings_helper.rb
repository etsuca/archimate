module BuildingsHelper
  def others_building
    Building.not_by(current_user)
  end

  def user_liked_building_ids
    Like.where(user_id: current_user.id).pluck(:building_id)
  end

  def random_building
    others_building.where.not(id: user_liked_building_ids).where(open_range: 'publish').sample
  end

  def building_images_url(building)
    building.images.map { |image| rails_blob_path(image) }.to_json.html_safe if building
  end
end
