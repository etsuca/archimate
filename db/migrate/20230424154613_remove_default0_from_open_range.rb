class RemoveDefault0FromOpenRange < ActiveRecord::Migration[6.1]
  def up
    change_column_default :architecture, :open_range, nil
  end

  def down
    change_column_default :architecture, :open_range, 0
  end
end
