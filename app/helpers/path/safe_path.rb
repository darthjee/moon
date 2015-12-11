module Path
  class SafePath
    attr_reader :controller, :method

    def initialize(controller, method)
      @controller = controller
      @method = method
    end

    def call_missing(*args)
      if /^(\w*)_safe_path$/ =~ method && does_respond_to?
        safe_path(/^(\w*)_safe_path$/.match(method)[1]+'_path', *args)
      end
    end

    def does_respond_to?
      if /^(\w*)_safe_path$/ =~ method
        controller.respond_to?(/^(\w*)_safe_path$/.match(method)[1]+'_path')
      end
    end

    def safe_path(path_method, args)
      keys = args.keys.map { |k| ":#{k}" }
      key_args = keys.as_hash(args.keys)

      path = controller.public_send(path_method, key_args)

      key_args.each do |key, key_s|
        regexp = Regexp.new("#{key_s}\\b")
        path.gsub!(regexp, args[key])
      end
      path
    end
  end
end