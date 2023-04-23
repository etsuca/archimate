class RenameIntroductionToDescription < ActiveRecord::Migration[6.1]
  def change
    rename_column :architecture, :introduction, :description
  end
end
