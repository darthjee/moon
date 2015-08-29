class Marriage::Redirector::Engine
  attr_reader :configs, :controller

  def initialize(configs, controller)
    @configs = configs
    @controller = controller
  end

  def perform_redirect?
    handlers.any? { |h| h.perform_redirect? }
  end

  private

  def handlers
    configs.map { |_,c| Marriage::Redirector::Handler.new(c, controller) }
  end
end