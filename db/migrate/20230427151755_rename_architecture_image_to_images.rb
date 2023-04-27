class RenameArchitectureImageToImages < ActiveRecord::Migration[6.1]
  def change
    rename_column :architecture, :architecture_image, :images
  end
end
