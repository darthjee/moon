module ApplicationHelper
  def angular_link_to(text, url, *args)
    link_to(text, "##{url}", *args)
  end
end
