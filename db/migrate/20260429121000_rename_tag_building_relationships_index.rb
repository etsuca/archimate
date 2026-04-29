class RenameTagBuildingRelationshipsIndex < ActiveRecord::Migration[6.1]
  def change
    return unless table_exists?(:tag_building_relationships)
    return unless index_name_exists?(:tag_building_relationships, :tag_archi_relationships)

    rename_index :tag_building_relationships, :tag_archi_relationships, :index_tag_building_relationships_on_tag_id_and_building_id
  end
end
