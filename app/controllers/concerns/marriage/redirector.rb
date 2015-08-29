module Marriage::Redirector
  extend ActiveSupport::Concern
  require 'marriage/redirector/class_methods'

  included do
    before_action :render_root
  end

  private

  def redirector_engine
    self.class.redirector_engine
  end

  def render_root
    redirect_to "##{request.path}" if redirector_engine.perform_redirect?(self)
  end
end