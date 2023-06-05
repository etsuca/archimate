class AddExperienceToArchitecture < ActiveRecord::Migration[6.1]
  def change
    add_column :architecture, :experience, :integer, null: false
  end
end
