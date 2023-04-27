class AddArchitectureImageToArchitecture < ActiveRecord::Migration[6.1]
  def change
    add_column :architecture, :architecture_image, :string
  end
end
