class Marriage::Redirector::Engine
  def initialize
  end

  def methods
    @methods ||= []
  end

  def blocks
    @blocks ||= []
  end

  def perform_redirect?(controller)
    methods_require_redirect?(controller) || blocks_require_redirect?
  end

  private

  def methods_require_redirect?(controller)
    methods.any? do |method|
      controller.send(method)
    end
  end

  def blocks_require_redirect?
    blocks.any? do |block|
      block.yield
    end
  end
end