module Marriage::Services
  extend ActiveSupport::Concern

  def mandrill_service
    Mandrill::Service.instance
  end
end
