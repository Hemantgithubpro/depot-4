class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    uri = URI.parse(value)

    unless (uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)) && uri.host.present?
      record.errors.add(attribute, :invalid)
    end
  rescue URI::InvalidURIError
    record.errors.add(attribute, :invalid)
  end
  # def validate_each(record, attribute, value)
  #   return if value.blank?

  #    unless value.match?(/\Ahttps?:\/\/[^\s]+\.[^\s]+\z/i)
  #     record.errors.add(attribute, :invalid)
  #    end
  # end
end
