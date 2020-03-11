class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if EmailValidator::Matcher.new(value).match
    record.errors[attribute] << I18n.t(options[:message] || 'errors.messages.invalid')
  end
end
