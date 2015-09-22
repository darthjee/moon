class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if EmailValidator::Matcher.new(value).match
    record.errors[attribute] << (options[:message] || :invalid_email_format)
  end
end
