class Marriage::Redirector::Engine
  def methods
    @methods ||= []
  end

  def skip_methods
    @skip_methods ||= []
  end

  def blocks
    @blocks ||= []
  end

  def skip_blocks
    @skip_blocks ||= []
  end

  def perform_redirect?(controller)
    return if methods_skip_redirect?(controller) || blocks_skip_redirect?
    methods_require_redirect?(controller) || blocks_require_redirect?
  end

  private

  def methods_skip_redirect?(controller)
    skip_methods.any? do |method|
      controller.send(method)
    end
  end

  def blocks_skip_redirect?
    skip_blocks.any? do |block|
      block.yield
    end
  end

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