module Marriage::Redirector
  extend ActiveSupport::Concern
  require 'marriage/redirector/class_methods'

  included do
    before_action :render_root
    redirection_rule :perform_angular_redirect?
  end

  private

  def redirector_engine
    self.class.redirector_engine
  end

  def render_root
    return if params[:ajax]
    redirect_to "##{request.path}" if redirector_engine.perform_redirect?(self)
  end

  def perform_angular_redirect?
    request.format.html? && !is_home?
  end

  def is_home?
    request.path == '/'
  end
end