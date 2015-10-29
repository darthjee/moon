class Mandrill::Request
  class Error < StandardError; end
  class NoRecepients < Error; end

  attr_reader :messages, :template_key, :settings
  delegate :template_name, to: :email_setting

  def initialize(messages, template_key, settings = {})
    @messages = [ messages ].flatten.map { |m| Mandrill::Message.new(m) }
    @template_key = template_key
    @settings = settings
    filter_recepients
  end

  def as_json(*args)
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

  private

  def email_setting
    @email_setting ||= Mandrill::EmailSetting.find_by(key: template_key)
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
