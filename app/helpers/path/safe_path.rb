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
  end
end
