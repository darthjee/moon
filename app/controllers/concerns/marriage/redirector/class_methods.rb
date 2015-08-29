module Marriage::Redirector::ClassMethods
  def redirection_rule(*methods, &block)
    redirector_engine.methods.concat methods
    redirector_engine.blocks << block if block_given?
  end

  def redirector_engine
    @redirector_engine ||= Marriage::Redirector::Engine.new
  end
end