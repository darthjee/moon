module Marriage::Redirector::ClassMethods
  def redirection_rule(redirection, *methods, &block)
    redirector_builder.add_redirection_config(redirection, *methods, block)
  end

  def skip_redirection_rule(redirection, *methods, &block)
    redirector_builder.add_skip_config(redirection, *methods, block)
  end

  def redirector_builder
    @redirector_builder ||= Marriage::Redirector::Builder.new
  end
end