module ApplicationHelper
  def angular_link_to(text, path, *args)
    link_to(text, angular_path_to(path), *args)
  end

  def angular_path_to(path)
    "##{path}"
  end

  def method_missing(method, *args)
    Path::SafePath.new(self, method).call_missing(*args) || super
  end

  def respond_to?(method)
    return true if Path::SafePath.new(self, method).does_respond_to?
    super
  end
end
