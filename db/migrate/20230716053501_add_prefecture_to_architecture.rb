class AddPrefectureToArchitecture < ActiveRecord::Migration[6.1]
  def change
    add_column :architecture, :pref, :string
  end
end
