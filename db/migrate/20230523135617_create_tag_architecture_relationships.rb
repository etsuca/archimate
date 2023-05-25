class CreateTagArchitectureRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_architecture_relationships do |t|
      t.references :architecture, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tag_architecture_relationships, [:tag_id, :architecture_id], unique: true, name: 'tag_archi_relationships'
  end
end
