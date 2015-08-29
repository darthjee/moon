class Marriage::Redirector::Handler
  attr_accessor :config, :controller

  delegate :methods, :skip_methods, :blocks, :skip_blocks, to: :config

  def initialize(config, controller)
    @config = config
    @controller = controller
  end

  def perform_redirect?
    return if methods_skip_redirect? || blocks_skip_redirect?
    methods_require_redirect? || blocks_require_redirect?
  end

  private

  def methods_skip_redirect?
    skip_methods.any? do |method|
      controller.send(method)
    end
  end

  def blocks_skip_redirect?
    skip_blocks.any? do |block|
      block.yield
    end
  end

  def methods_require_redirect?
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