class AddPrefectureToBuilding < ActiveRecord::Migration[6.1]
  def change
    add_column :buildings, :pref, :string
  end
end
