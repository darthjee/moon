# frozen_string_literal: true

class Mandrill::Request
  class Error < StandardError; end
  class NoRecepients < Error; end
  class NoConfig < Error; end

  attr_reader :messages_hash, :template_key, :settings
  delegate :template_name, to: :email_setting

  def initialize(messages_hash, template_key, settings = {})
    @messages_hash = messages_hash
    @template_key = template_key
    @settings = settings
    filter_recepients
  end

  def as_json(*_args)
    settings.merge(
      to: recepients,
      merge_vars: messages.map(&:as_json)
    )
  end

  def recepients
    messages.map(&:recepient).map(&:as_json)
  end

  def has_recepients?
    recepients.present?
  end

  def messages
    @messages ||= [
      messages_hash
    ].flatten.map do |m|
      Mandrill::Message.parse(m)
    end
  end

  def ==(other)
    return false unless other.class == self.class

    messages == other.messages
  end

  private

  def email_setting
    @email_setting ||= Mandrill::EmailSetting.find_by!(key: template_key)
  rescue ActiveRecord::RecordNotFound => e
    raise NoConfig, e
  end

  def settings
    {
      headers: headers,
      return_path_domain: Mandrill.return_path_domain
    }.merge @settings
  end

  def headers
    {
      'Reply-To' => Mandrill.reply_to
    }
  end

  def filter_recepients
    messages.select! { |m| m.recepient.allowed? }
  end
end
