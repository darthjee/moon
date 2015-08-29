module Marriage::Redirector::ClassMethods
  def redirection_rule(*methods, &block)
    redirector_engine.methods.concat methods
    redirector_engine.blocks << block if block_given?
  end

  def skip_redirection_rule(*methods, &block)
    redirector_engine.skip_methods.concat methods
    redirector_engine.skip_blocks << block if block_given?
  end

  def redirector_engine
    @redirector_engine ||= Marriage::Redirector::Engine.new
  end
end