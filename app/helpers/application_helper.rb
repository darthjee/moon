module ApplicationHelper
  def angular_link_to(text, path, *args)
    link_to(text, angular_path_to(path), *args)
  end

  def angular_path_to(path)
    "##{path}"
  end

  def method_missing(method, *args)
    if /^(\w*)_safe_path$/ =~ method && respond_to?(/^(\w*)_safe_path$/.match(method)[1]+'_path')
      safe_path(/^(\w*)_safe_path$/.match(method)[1]+'_path', *args)
    else
      super
    end
  end

  def respond_to?(method)
    if /^(\w*)_safe_path$/ =~ method
      respond_to?(/^(\w*)_safe_path$/.match(method)[1]+'_path')
    else
      super
    end
  end

  def safe_path(path_method, args)
    keys = args.keys.map { |k| ":#{k}" }
    key_args = keys.as_hash(args.keys)

    path = public_send(path_method, key_args)

    key_args.each do |key, key_s|
      regexp = Regexp.new("#{key_s}\\b")
      path.gsub!(regexp, args[key])
    end
    path
  end
end
