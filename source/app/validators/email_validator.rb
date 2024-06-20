# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if EmailValidator::Matcher.new(value).match

    key = options[:message] || 'errors.messages.invalid'
    record.errors.add(attribute, :invalid_email, message: I18n.t(key))
  end
end
