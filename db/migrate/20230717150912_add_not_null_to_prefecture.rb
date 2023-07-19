class AddNotNullToPrefecture < ActiveRecord::Migration[6.1]
  def change
    change_column :architecture, :pref, :string, null: false
  end
end
