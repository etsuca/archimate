class CreateTagBuildingRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_building_relationships do |t|
      t.references :building, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tag_building_relationships, [:tag_id, :building_id], unique: true, name: 'index_tag_building_relationships_on_tag_id_and_building_id'
  end
end
