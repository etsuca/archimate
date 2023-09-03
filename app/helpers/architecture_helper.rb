module ArchitectureHelper
  def others_architecture
    Architecture.not_by(current_user)
  end

  def user_liked_architecture_ids
    Like.where(user_id: current_user.id).pluck(:architecture_id)
  end

  def random_architecture
    others_architecture.where.not(id: user_liked_architecture_ids).where(open_range: 'publish').sample
  end

  def architecture_images_url(architecture)
    architecture.images.map { |image| rails_blob_path(image) }.to_json.html_safe if architecture
  end
end
