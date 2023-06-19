class RemoveImagesFromArchitecture < ActiveRecord::Migration[6.1]
  def up
    remove_column :architecture, :images
  end

  def down
    add_column :architecture, :images, :string
  end
end
