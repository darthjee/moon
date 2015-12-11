class Path::SafePath::PathCaller
  attr_reader :controller, :method, :args

  def initialize(controller, method, args)
    @controller = controller
    @method = method
    @args = args
  end

  def path
    c_path = controller_path
    key_args.each do |key, key_s|
      regexp = Regexp.new("#{key_s}\\b")
      c_path.gsub!(regexp, args[key])
    end
    c_path
  end

  private

  def keys
    @keys ||= args.keys.map { |k| ":#{k}" }
  end

  def key_args
    @key_args ||= keys.as_hash(args.keys)
  end

  def controller_path
    @controller_path ||= controller.public_send(method, key_args)
  end
end
