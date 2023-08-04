class AddTmpMatchTagCountToArchitecture < ActiveRecord::Migration[6.1]
  def change
    add_column :architecture, :tmp_match_tag_count, :integer, default: 0
  end
end
