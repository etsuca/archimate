class CreateArchitecture < ActiveRecord::Migration[6.1]
  def change
    create_table :architecture do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :architect
      t.text :introduction
      t.references :user, null: false, foreign_key: true
      t.references :open_range, null: false, foreign_key: true

      t.timestamps
    end
  end
end
