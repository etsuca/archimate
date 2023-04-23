class CreateOpenRanges < ActiveRecord::Migration[6.1]
  def change
    create_table :open_ranges do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
