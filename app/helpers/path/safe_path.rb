module Path
  class SafePath
    attr_reader :controller, :method

    MATCHER = /^(\w*)_safe_path$/

    def initialize(controller, method)
      @controller = controller
      @method = method
    end

    def call_missing(*args)
      if MATCHER =~ method && does_respond_to?
        safe_path(MATCHER.match(method)[1]+'_path', *args)
      end
    end

    def does_respond_to?
      if MATCHER =~ method
        controller.respond_to?(MATCHER.match(method)[1]+'_path')
      end
    end

    private

    def safe_path(path_method, args)
      PathCaller.new(controller, path_method, args).path
    end

    class PathCaller
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
  end
end
