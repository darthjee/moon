module ApplicationHelper
  def angular_link_to(text, path, *args)
    link_to(text, angular_path_to(path), *args)
  end

  def angular_path_to(path)
    "##{path}"
  end
end
