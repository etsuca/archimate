class AttachedFileTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true unless value.attached?
    return true unless options&.dig(:pattern)

    pattern = options[:pattern]
    attachments = value.is_a?(ActiveStorage::Attached::Many) ? value.attachments : [value.attachment]
    record.errors.add(attribute, :invalid_file_type) if attachments.any? { |attachment| !attachment.content_type.match?(pattern) }
  end
end
