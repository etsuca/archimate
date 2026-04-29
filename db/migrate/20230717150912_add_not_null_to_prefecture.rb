class AddNotNullToPrefecture < ActiveRecord::Migration[6.1]
  def up
    change_column :buildings, :pref, :string, null: false
  end
end
