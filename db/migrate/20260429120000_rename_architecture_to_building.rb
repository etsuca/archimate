class RenameArchitectureToBuilding < ActiveRecord::Migration[6.1]
  def up
    rename_table :architecture, :buildings if table_exists?(:architecture) && !table_exists?(:buildings)

    if table_exists?(:likes) && column_exists?(:likes, :architecture_id) && !column_exists?(:likes, :building_id)
      rename_column :likes, :architecture_id, :building_id
    end

    if table_exists?(:tag_architecture_relationships) && !table_exists?(:tag_building_relationships)
      rename_table :tag_architecture_relationships, :tag_building_relationships
    end

    if table_exists?(:tag_building_relationships) &&
       column_exists?(:tag_building_relationships, :architecture_id) &&
       !column_exists?(:tag_building_relationships, :building_id)
      rename_column :tag_building_relationships, :architecture_id, :building_id
    end
  end

  def down
    if table_exists?(:tag_building_relationships) &&
       column_exists?(:tag_building_relationships, :building_id) &&
       !column_exists?(:tag_building_relationships, :architecture_id)
      rename_column :tag_building_relationships, :building_id, :architecture_id
    end

    rename_table :tag_building_relationships, :tag_architecture_relationships if table_exists?(:tag_building_relationships) && !table_exists?(:tag_architecture_relationships)

    if table_exists?(:likes) && column_exists?(:likes, :building_id) && !column_exists?(:likes, :architecture_id)
      rename_column :likes, :building_id, :architecture_id
    end

    rename_table :buildings, :architecture if table_exists?(:buildings) && !table_exists?(:architecture)
  end
end
