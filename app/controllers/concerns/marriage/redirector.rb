module Marriage::Redirector
  extend ActiveSupport::Concern
  require 'marriage/redirector/class_methods'

  included do
    before_action :perform_redirection
  end

  private

  def redirector_engine
    self.class.redirector_builder.build(self)
  end

  def perform_redirection
     redirect_to "##{request.path}" if redirector_engine.perform_redirect?
  end
end
