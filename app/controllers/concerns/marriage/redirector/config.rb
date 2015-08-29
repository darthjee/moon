class Marriage::Redirector::Config
  def add_redirection_rules(*methods, &block)
    self.methods.concat methods
    blocks << block if block_given?
  end

  def add_skip_rules(*methods, &block)
    skip_methods.concat methods
    skip_blocks << block if block_given?
  end

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
end