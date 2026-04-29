class AddTmpMatchTagCountToBuilding < ActiveRecord::Migration[6.1]
  def change
    add_column :buildings, :tmp_match_tag_count, :integer, default: 0
  end
end
