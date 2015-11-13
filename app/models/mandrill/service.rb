class Mandrill::Service
  include Singleton

  delegate :messages, to: :client
  delegate :send_template, to: :messages

  def send_request(request)
    raise Mandrill::Request::NoRecepients unless request.has_recepients?
    send_template request.template_name, [], request.as_json
  end

  private

  def client
    @client ||= Mandrill::API.new Mandrill.key
  end
end
