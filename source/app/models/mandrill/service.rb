# frozen_string_literal: true

class Mandrill::Service
  include Singleton

  delegate :messages, to: :client
  delegate :send_template, to: :messages

  def send_request(request)
    raise Mandrill::Request::NoRecepients unless request.recepients?

    send_template request.template_name, [], request.as_json
  end

  def recover_password(user, root_url)
    request = Mandrill::Request::Password.new(user, root_url)
    send_request(request)
  end

  def update_honor(root_url)
    users = User.where(invite_honor: true)
    users.each do |user|
      request = Mandrill::Request::HonorUpdate.new(user, root_url)
      send_request(request)
    end
  end

  private

  def client
    @client ||= Mandrill::API.new Mandrill.key
  end
end
