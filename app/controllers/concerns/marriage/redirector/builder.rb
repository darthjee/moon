class Marriage::Redirector::Builder
  def add_redirection_config(redirection, *methods, block)
    config_for(redirection).add_redirection_rules(*methods, &block)
  end

  def add_skip_config(redirection, *methods, block)
    config_for(redirection).add_skip_rules(*methods, &block)
  end

  def build(controller)
    Marriage::Redirector::Engine.new(configs, controller)
  end

  private

  def config_for(redirection)
    configs[redirection.to_sym] ||= Marriage::Redirector::Config.new
  end

  def configs
    @configs ||= {}
  end
end