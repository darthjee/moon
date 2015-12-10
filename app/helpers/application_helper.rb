module ApplicationHelper
  def angular_link_to(text, path, *args)
    link_to(text, angular_path_to(path), *args)
  end

  def angular_path_to(path)
    "##{path}"
  end

  def marriage_gift_gift_link_safe_path(args)
    keys = args.keys.map { |k| ":#{k}" }
    key_args = keys.as_hash(args.keys)

    path = marriage_gift_gift_link_path(key_args)

    key_args.each do |key, key_s|
      regexp = Regexp.new("#{key_s}\\b")
      path.gsub!(regexp, args[key])
    end
    path
  end
end
