class RenameActiveStorageRecordTypeToBuilding < ActiveRecord::Migration[6.1]
  def up
    return unless table_exists?(:active_storage_attachments)

    execute <<~SQL.squish
      UPDATE active_storage_attachments
      SET record_type = 'Building'
      WHERE record_type = 'Architecture'
    SQL
  end

  def down
    return unless table_exists?(:active_storage_attachments)

    execute <<~SQL.squish
      UPDATE active_storage_attachments
      SET record_type = 'Architecture'
      WHERE record_type = 'Building'
    SQL
  end
end
